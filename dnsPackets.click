source::FromDevice                                                                                 
dest::ToDevice                                                                                     

c::Classifier(36/0035, 34/0035, -);

flagsFilter::Classifier(44/00, 44/01, 44/02, 44/03, 
			44/08, 44/09, 44/0a, 44/0b,
			44/10, 44/11, 44/12, 44/13,
			-);       
                      
questionCount::Classifier(46/0001, -);

answerCount::Classifier(48/00, -);                  

authoritativeCount::Classifier(50/00, -);

additionalCount::Classifier(52/00, -);                 

queryType::Classifier(63/0002, 66/0010, 66/000f, 66/001d, 67/00ff, 70/0001, 70/001c, 71/001c, 72/001c, 75/001c, 81/000c, -);

queryClass::Classifier(68/0001, 68/0002, 68/0003, 68/0004, -);

responseFlagFilter1::Classifier(44/80, 44/81, 44/82, 44/83, 44/84, 44/85, 44/86, 44/87, 
				44/88, 44/89, 44/8a, 44/8b, 44/8c, 44/8d, 44/8e, 44/8f, 
				44/90, 44/91, 44/92, 44/93, 44/94, 44/95, 44/96, 44/97, -);

responseFlagFilter2::Classifier(45/00, 45/01, 45/02, 45/03,
				45/80, 45/81, 45/82, 45/83, -);

responseQuestionCount::Classifier(46/0001, -);

responseAnswerCount::Classifier(48/0000, 48/0001, 48/0002, 48/0003, 48/0004, 48/0005, 48/0006, 
				48/0007, 48/0008, 48/0009, 48/000a, -);

responseAuthoritativeCount::Classifier(50/0000, 50/0001, 50/0002, 50/0003, 50/0004, 50/0005,
					50/0006, 50/0007, 50/0008, 50/0009, 50/000a, -);

responseAdditionalCount::Classifier(52/0000, 52/0001, 52/0002, 52/0003, 52/0004, 52/0005,
					52/0006, 52/0007, 52/0008, 52/0009, 52/000a, -);

responseType::Classifier(69/0002, 72/000f, 72/0010, 73/001c, 76/0001, 76/001c, 77/0005, 84/000c,
			87/000c, -);

responseClassType::Classifier(71/0001 72/0001 74/0001 78/0001 79/0001 86/0001 89/0001, -);
                                                                              
source -> c                                                                                        

c[0] -> Print('DNS Request') -> flagsFilter;                                              
c[1] -> Print('DNS Response') -> responseFlagFilter1;                                             
c[2] -> Print('Other packets') -> dest;

flagsFilter[0] -> Print('Query Opcode: Standard query, TC: Message not truncated, RD: Non-recursive query') -> questionCount;
flagsFilter[1] -> Print('Query Opcode: Standard query, TC: Message not truncated, RD: Recursive query') -> questionCount;
flagsFilter[2] -> Print('Query Opcode: Standard query, TC: Message truncated, RD: Non-recursive query') -> questionCount;
flagsFilter[3] -> Print('Query Opcode: Standard query, TC: Message truncated, RD: Recursive query') -> questionCount;
flagsFilter[4] -> Print('Query Opcode: Inverse query, TC: Message not truncated, RD: Non-recusrive query') -> questionCount;
flagsFilter[5] -> Print('Query Opcode: Inverse query, TC: Message not truncated, RD: Recursive query') -> questionCount;
flagsFilter[6] -> Print('Query Opcode: Inverse query, TC: Message truncated, RD: Non-recursive query') -> questionCount;
flagsFilter[7] -> Print('Query Opcode: Inverse query, TC: Message truncated, RD: Recursive query') -> questionCount;
flagsFilter[8] -> Print('Query Opcode: Server status request, TC: Message not truncated, RD: Non-recursive query') -> questionCount;
flagsFilter[9] -> Print('Query Opcode: Server status request, TC: Message not truncated, RD: Recursive query') -> questionCount;
flagsFilter[10] -> Print('Query Opcode: Server status request, TC: Message truncated, RD: Non-recursive query') -> questionCount;
flagsFilter[11] -> Print('Query Opcode: Server status request, TC: Message truncated, RD: Recursive query') -> questionCount;
flagsFilter[12] -> Print('Other flags') -> questionCount;

questionCount[0] -> Print('Number of questions: 1') -> answerCount;
questionCount[1] -> Print('More than 1 question') -> answerCount;

answerCount[0] -> Print('Answer count is 0 in a query message') -> authoritativeCount;
answerCount[1] -> Print('Answer count not 0. Malformed query') -> authoritativeCount;

authoritativeCount[0] -> Print('Authoritative record count is 0 in a query message')-> additionalCount;
authoritativeCount[1] -> Print('Authoritative record count is not 0. Malformed query') -> additionalCount;

additionalCount[0] -> Print('Additional record count is 0 in a query message') -> queryType;
additionalCount[1] -> Print('Additional record count is not 0. Malformed query') -> queryType;

queryType[0] -> Print('Type of Record: Authoritative Name Server') -> queryClass;
queryType[1] -> Print('Type of Record: TXT-Text strings') -> queryClass;
queryType[2] -> Print('Type of Record: MX-Mail exchange') -> queryClass;
queryType[3] -> Print('Type of Record: LOC-Location Information') -> queryClass;
queryType[4] -> Print('Type of Record: ANY') -> queryClass;
queryType[5] -> Print('Type of Record: A-IPv4 Address') -> queryClass;
queryType[6] -> Print('Type of Record: AAAA-IPv6 Address') -> queryClass;
queryType[7] -> Print('Type of Record: AAAA-IPv6 Address') -> queryClass;
queryType[8] -> Print('Type of Record: AAAA-IPv6 Address') -> queryClass;
queryType[9] -> Print('Type of Record: AAAA-IPv6 Address') -> queryClass;
queryType[10] -> Print('Type of record: PTR-Domain name pointer') -> queryClass;
queryType[11] -> Print('Other record types') -> queryClass;

queryClass[0] -> Print('Class Type: Internet') -> dest;
queryClass[1] -> Print('Class Type: CSNET') -> dest;
queryClass[2] -> Print('Class Type: CHAOS') -> dest;
queryClass[3] -> Print('Class Type: HESIOD') -> dest;
queryClass[4] -> Print('Class Type: Others') -> dest;

responseFlagFilter1[0] -> Print('Response Opcode: Standard Query Response, AA: Not an authoritative server, TC: Message not truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2;
responseFlagFilter1[1] -> Print('Response Opcode: Standard Query Response, AA: Not an authoritative server, TC: Message not truncated, RD: Client needs a recursive answer') -> responseFlagFilter2;
responseFlagFilter1[2] -> Print('Response Opcode: Standard Query Response, AA: Not an authoritative server, TC: Message Truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2;
responseFlagFilter1[3] -> Print('Response Opcode: Standard Query Response, AA: Not an authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[4] -> Print('Response Opcode: Standard Query Response, AA: Authoritative server, TC: Message not truncated, RD: Client does not need an authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[5] -> Print('Response Opcode: Standard Query Response, AA: Authoritative server, TC: Message not truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[6] -> Print('Response Opcode: Standard Query Response, AA: Authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[7] -> Print('Response Opcode: Standard Query Response, AA: Authoritative server, TC: Message Truncated, RD: Client needs and authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[8] -> Print('Response Opcode: Inverse Query Response, AA: Not an authoritative server, TC: Message not truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2; 
responseFlagFilter1[9] -> Print('Response Opcode: Inverse Query Response, AA: Not an authoritative server, TC: Message not truncated, RD: Client needs a recursive answer') -> responseFlagFilter2;
responseFlagFilter1[10] -> Print('Response Opcode: Inverse, AA: Not an authoritative server, TC: Message Truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2;          
responseFlagFilter1[11] -> Print('Response Opcode: Inverse Query Response, AA: Not an authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[12] -> Print('Response Opcode: Inverse Query Response, AA: Authoritative server, TC: Message not truncated, RD: Client does not need an authoritative answer') -> responseFlagFilter2;         
responseFlagFilter1[13] -> Print('Response Opcode: Inverse Query Response, AA: Authoritative server, TC: Message not truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2; 
responseFlagFilter1[14] -> Print('Response Opcode: Inverse Query Response, AA: Authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;     
responseFlagFilter1[15] -> Print('Response Opcode: Inverse Query Response, AA: Authoritative server, TC: Message Truncated, RD: Client needs and authoritative answer') -> responseFlagFilter2; 
responseFlagFilter1[16] -> Print('Response Opcode: Server status query response, AA: Not an authoritative server, TC: Message not truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2;        
responseFlagFilter1[17] -> Print('Response Opcode: Server status query response, AA: Not an authoritative server, TC: Message not truncated, RD: Client needs a recursive answer') -> responseFlagFilter2;               
responseFlagFilter1[18] -> Print('Response Opcode: Server status query response, AA: Not an authoritative server, TC: Message Truncated, RD: Client does not need a recursive answer') -> responseFlagFilter2;           
responseFlagFilter1[19] -> Print('Response Opcode: Server status query response, AA: Not an authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;              
responseFlagFilter1[20] -> Print('Response Opcode: Server status query response, AA: Authoritative server, TC: Message not truncated, RD: Client does not need an authoritative answer') -> responseFlagFilter2;         
responseFlagFilter1[21] -> Print('Response Opcode: Server status query response, AA: Authoritative server, TC: Message not truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2;                 
responseFlagFilter1[22] -> Print('Response Opcode: Server status query response, AA: Authoritative server, TC: Message Truncated, RD: Client needs an authoritative answer') -> responseFlagFilter2
responseFlagFilter1[23] -> Print('Response Opcode: Server status query response, AA: Authoritative server, TC: Message Truncated, RD: Client needs and authoritative answer') -> responseFlagFilter2;
responseFlagFilter1[24] -> Print('Other response flag 1') -> responseFlagFilter2;

responseFlagFilter2[0] -> Print('RA: Recursive response not available, Response Code: No error') -> responseQuestionCount;
responseFlagFilter2[1] -> Print('RA: Recursive response not available, Response Code: Format error') -> responseQuestionCount;
responseFlagFilter2[2] -> Print('RA: Recursive response not available, Response Code: Server failure') -> responseQuestionCount;
responseFlagFilter2[3] -> Print('RA: Recursive response not available, Response Code: Domain name does not exist') -> responseQuestionCount;
responseFlagFilter2[4] -> Print('RA: Recursive response available, Response Code: No error') -> responseQuestionCount;
responseFlagFilter2[5] -> Print('RA: Recursive response available, Response Code: Format error') -> responseQuestionCount;
responseFlagFilter2[6] -> Print('RA: Recursive response available, Response Code: Server failure') -> responseQuestionCount;
responseFlagFilter2[7] -> Print('RA: Recursive response available, Response Code: Domain name does not exist') -> responseQuestionCount;
responseFlagFilter2[8] -> Print('Other response flag 2') -> responseQuestionCount;

responseQuestionCount[0] -> Print('Response for 1 question') -> responseAnswerCount;
responseQuestionCount[1] -> Print('No response sent if there is more than 1 query. Malformed packet') -> responseAnswerCount;

responseAnswerCount[0] -> Print('No answers available') -> responseAuthoritativeCount;
responseAnswerCount[1] -> Print('Answer Count: 1') -> responseAuthoritativeCount;
responseAnswerCount[2] -> Print('Answer Count: 2') -> responseAuthoritativeCount;
responseAnswerCount[3] -> Print('Answer Count: 3') -> responseAuthoritativeCount;
responseAnswerCount[4] -> Print('Answer Count: 4') -> responseAuthoritativeCount;
responseAnswerCount[5] -> Print('Answer Count: 5') -> responseAuthoritativeCount;
responseAnswerCount[6] -> Print('Answer Count: 6') -> responseAuthoritativeCount;
responseAnswerCount[7] -> Print('Answer Count: 7') -> responseAuthoritativeCount;
responseAnswerCount[8] -> Print('Answer Count: 8') -> responseAuthoritativeCount;
responseAnswerCount[9] -> Print('Answer Count: 9') -> responseAuthoritativeCount;
responseAnswerCount[10] -> Print('Answer Count: 10') -> responseAuthoritativeCount;
responseAnswerCount[11] -> Print('Answer Count: More than 10') -> responseAuthoritativeCount;

responseAuthoritativeCount[0] -> Print('No authoritative answers') -> responseAdditionalCount;
responseAuthoritativeCount[1] -> Print('Authoritative Answer Count: 1') -> responseAdditionalCount;
responseAuthoritativeCount[2] -> Print('Authoritative Answer Count: 2') -> responseAdditionalCount;responseAuthoritativeCount[3] -> Print('Authoritative Answer Count: 3') -> responseAdditionalCount;
responseAuthoritativeCount[4] -> Print('Authoritative Answer Count: 4') -> responseAdditionalCount;
responseAuthoritativeCount[5] -> Print('Authoritative Answer Count: 5') -> responseAdditionalCount;
responseAuthoritativeCount[6] -> Print('Authoritative Answer Count: 6') -> responseAdditionalCount;
responseAuthoritativeCount[7] -> Print('Authoritative Answer COunt: 7') -> responseAdditionalCount;
responseAuthoritativeCount[8] -> Print('Authoritative Answer Count: 8') -> responseAdditionalCount;
responseAuthoritativeCount[9] -> Print('Authoritative Answer Count: 9') -> responseAdditionalCount;
responseAuthoritativeCount[10] -> Print('Authoritative Answer Count: 10') -> responseAdditionalCount;
responseAuthoritativeCount[11] -> Print('Authoritative Answer Count: More than 10') -> responseAdditionalCount;

responseAdditionalCount[0] -> Print('No additional answers') -> responseType;
responseAdditionalCount[1] -> Print('Additional Answer Count: 1') -> responseType;
responseAdditionalCount[2] -> Print('Additional Answer Count: 2') -> responseType;
responseAdditionalCount[3] -> Print('Additional Answer Count: 3') -> responseType;
responseAdditionalCount[4] -> Print('Additional Answer Count: 4') -> responseType;
responseAdditionalCount[5] -> Print('Additional Answer Count: 5') -> responseType;
responseAdditionalCount[6] -> Print('Additional Answer Count: 6') -> responseType;
responseAdditionalCount[7] -> Print('Additional Answer Count: 7') -> responseType;
responseAdditionalCount[8] -> Print('Additional Answer Count: 8') -> responseType;
responseAdditionalCount[9] -> Print('Additional Answer Count: 9') -> responseType;
responseAdditionalCount[10] -> Print('Additional Answer Count: 10') -> responseType;
responseAdditionalCount[11] -> Print('Additional Answer Count: More than 10') -> responseType;

responseType[0] -> Print('Type of Record: Authoritative Name server') -> responseClassType;
responseType[1] -> Print('Type of Record: MX-Mail exchange') -> responseClassType;
responseType[2] -> Print('Type of Record: TXT-Text strings') -> responseClassType;
responseType[3] -> Print('Type of Record: AAAA-IPv6 address') -> responseClassType;
responseType[4] -> Print('Type of Record: A-IPv4 address') -> responseClassType;
responseType[5] -> Print('Type of Record: AAAA-IPv6 address') -> responseClassType;
responseType[6] -> Print('Type of Record: CNAME-Canonical Name') -> responseClassType;
responseType[7] -> Print('Type of Record: PTR-Domain name pointer') -> responseClassType;
responseType[8] -> Print('Type of Record: PTR-Domain name pointer') -> responseClassType;
responseType[9] -> Print('Other response records') -> responseClassType;

responseClassType[0] -> Print('Response Class Type: Internet') -> dest;
responseClassType[1] -> Print('Response Classs Type: Others') -> dest;

