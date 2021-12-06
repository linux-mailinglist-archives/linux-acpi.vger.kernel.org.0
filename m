Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745DE46A4AC
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Dec 2021 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhLFShJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Dec 2021 13:37:09 -0500
Received: from mail-dm6nam10hn2246.outbound.protection.outlook.com ([52.100.156.246]:41185
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237265AbhLFShJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Dec 2021 13:37:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+MjMXqbqfdRR8NtXtw/FXDU+UOBuXlwYWbgSiZziNtwznO2t9x/2HNt1YEf0lOwz+41S3z0Rp2CSALZj43tz0vDWvWVnhAeFz7ol+luIRj8p50SvDqBPU1663Mq+uR4pxb72NNfbHSGITKTSEX3cXyJgBq2X+ert09S1YTEJb4qAucGMgIztO1OaMEmS4TMOsl3edmUgk3ejaQQAH1U+RtIIJsfhQuscKuHoobD+9NZiyz4va7Hkb8i9YNVqcBTHnmFQhZPgXgueiLNLZ9hFAJF+UCKZ4vxsJMTDRMy/DhTCWYq9o7iHu+7kNLloXY7kRt4IfHU3vXjjCXkygsYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=gpNMYY8t4GSpk25k40i0XnnnxfiCjjvTHyTg3YRW5aEf2vvWzicwPoQ+bMRhL04BURKMToMo0u/6IADkLme5XbO+3joDvqrzLTwRlHEIRDgsrBia0PYt530Jk0zujtVaI2CovhOPiOsoA/7EyGpKzLhICIj/ui8n9wfdMkzr5qJHQz50rUDM32wVzpMvVQVZ9Y+uPriGiUh2XrRQa6rXAzhV0Bd3bCptZNNZEI1vyaa2xAeu0UWNv3MM05zHkGbiB1frCTILM/t460T+IAbbYozVGdnuCGi/Ql3EsA9qF73bZFpaKIK8gtxh1UzNEmKv7f0iA7+9XGzMSEmJl/MhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.201.107.145) smtp.rcpttodomain=reddit.com smtp.mailfrom=msn.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=msn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsu.onmicrosoft.com;
 s=selector2-fsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=PtvofrQIB2zd3qIRfIn0/+lNIewrNyW6mkXpeGuj346l4rH0Gjwr2pBew4ykBMDhhjWf+Baeh6qoSQONn0+osPxrM3W0MGO54WoGoKRrkDVbJIOT1ACfEStHTjZGa31fGcBTvZDzhdle4o40IH+XX49aEIhKJboLtCd8Poo4VWE=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by PH0P220MB0569.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 18:33:31 +0000
Received: from BN8NAM04FT016.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::da) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Mon, 6 Dec 2021 18:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.201.107.145) smtp.mailfrom=msn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=msn.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 msn.com discourages use of 146.201.107.145 as permitted sender)
Received: from mailrelay03.its.fsu.edu (146.201.107.145) by
 BN8NAM04FT016.mail.protection.outlook.com (10.13.161.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 18:33:31 +0000
Received: from [10.0.0.200] (ani.stat.fsu.edu [128.186.4.119])
        by mailrelay03.its.fsu.edu (Postfix) with ESMTP id 7F293951A0;
        Mon,  6 Dec 2021 13:32:57 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: From Fred!
To:     Recipients <fred128@msn.com>
From:   "Fred Gamba." <fred128@msn.com>
Date:   Mon, 06 Dec 2021 19:32:16 +0100
Reply-To: fred_gamba@yahoo.co.jp
Message-ID: <3044fa8b-c7bf-49d3-bc40-a44918a978aa@BN8NAM04FT016.eop-NAM04.prod.protection.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cf24cc9-08e2-46a2-fd27-08d9b8e6e796
X-MS-TrafficTypeDiagnostic: PH0P220MB0569:EE_
X-Microsoft-Antispam-PRVS: <PH0P220MB0569DA6E51B931CC30636C4FEB6D9@PH0P220MB0569.NAMP220.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:146.201.107.145;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mailrelay03.its.fsu.edu;PTR:mailrelay03.its.fsu.edu;CAT:OSPM;SFS:(4636009)(84050400002)(46966006)(40470700001)(786003)(316002)(356005)(6666004)(35950700001)(31686004)(2906002)(83380400001)(26005)(6266002)(86362001)(70206006)(336012)(31696002)(5660300002)(7406005)(7596003)(7366002)(2860700004)(6200100001)(9686003)(70586007)(82202003)(47076005)(7116003)(6862004)(3480700007)(8676002)(8936002)(7416002)(508600001)(82310400004)(956004)(40460700001)(480584002);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzFFdUlyTzlRbktsV0czckRteWhuejVHVjJ6Kzlnc3pOVS9LbUVwbGNiWE1l?=
 =?utf-8?B?eERFaU04NWY0RDY3S3pPWjVtOFFNQVdSTld1amt0RXJlRnVPS2tidGZoMU1D?=
 =?utf-8?B?MStqS2xpa0x3d201YUtmNmI1d3NodzRMVmp0cmhTT1p5dHpBS0NuMmVXRUdJ?=
 =?utf-8?B?VWxkVjdvQ2NFTU9ISm1yc2xFTkdkWnQvdFJjNWhkQ3Y2d3lHenQ4NjRXN00z?=
 =?utf-8?B?bnc2bStyN2ZmSGpEdUVCMGV4TGRGVUVrVEJjM0FCUGtwSUdiV2R6bWxHSFhU?=
 =?utf-8?B?Q3dLdzZmR1ZnM3hiemxoL1F1b3FvUWtUR24yK0xRblJtNEI5dXFncHZDMjRE?=
 =?utf-8?B?aXV3aDlMZ0daWS9wcEdHbFBCaXJGaUttUWZyZWF1R0NLaFNhOWZVSjdGRzFm?=
 =?utf-8?B?QkJNSWRLUi83clpzRVdSNStlZmlLZS9yNW1IVFE2QThDdHFDNnA0MW1OSk45?=
 =?utf-8?B?YTdjcGFsQlhuck5lTUlSaG4zNjN2MjI3emlKWGJjMFVTak9xcFVPM3pjeUVi?=
 =?utf-8?B?a2dNYS9SMld5Y1NkRTByUkdkSmYvSkM4eXRreUl0OFZyUjRNQkV4dTkxZ1pi?=
 =?utf-8?B?OWNqSmxIeU1oWlZtc0xtUWI1NHhRak9SRUdtYkxoWXU2Rldib3MvcDNRazJ5?=
 =?utf-8?B?UDBBZ084MHFPbVhiVU1YRzdweWI3ZHpydzhyOXZRUjRYais4Zyt6NEhhRjRh?=
 =?utf-8?B?dzdUWEpjQWg3WnU2Si9lQ1E2bXR1Z25aamVudHRYdC82L3lWR29WZEdEMUxY?=
 =?utf-8?B?cEJFT2FyeHFiRDIxSVNkSjJxOHVBMW9RTWJGcDhTS2FzRW5qNE0yNkJVSkc5?=
 =?utf-8?B?WXBMZ2dIQzBvTEc0aGhKdjNHTk1ablVkU2RFVVc3Z3VEN25Xci8ya04rUFR4?=
 =?utf-8?B?OEZXWmpxYkdUaUllallYOEhLOVNBSW1rQzNKTUpBZWhobEdDVGVYK2ZmTHV5?=
 =?utf-8?B?VGk2Z3FOc29SRmxHZFUvbTA2cTBqSXg1bkUzOWxZRWVob3Z2R1F2WjV6WnFa?=
 =?utf-8?B?b0F2RFJiUXdIaXkrdEhNSEhnUTNYNlpaaW5qQXRMcjZOVTFsUmlYNW80MUpT?=
 =?utf-8?B?VVBGSFdIMklSSFJQWE42MzBwOUszcStNQjc0MklsTWVpRzN5OU1NT2FmbE4r?=
 =?utf-8?B?NFVFRmN1ZnFHR29LTmFDd05xdjBMNjBXdXdBczRHdCtUWFl2eHBRa1dXUk8x?=
 =?utf-8?B?YVk0UGI4ejRCZWtYLzNCRnBGOFlFS3FuMDlaN3crRjN6RExBdWlocVpQNnhS?=
 =?utf-8?B?YjI5dC9yaUY0VGxlZm41cHJnYS8zeVl5SzR0TU1qL1VLeTRKaFhoQ0FtdjhE?=
 =?utf-8?B?aGg5UHRrYlNCOUJFK2ZQL1h0RitYV2JSRmdYenY3UjB1S0R4YzUyT1JqYzRU?=
 =?utf-8?B?ZjdEMFUyS0tOeGxOL3dwd3JSNFVXVVFwbDRXYkZBM2pVZ2ExR3EvMHY3VG44?=
 =?utf-8?Q?fakNZXqy?=
X-OriginatorOrg: fsu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 18:33:31.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf24cc9-08e2-46a2-fd27-08d9b8e6e796
X-MS-Exchange-CrossTenant-Id: a36450eb-db06-42a7-8d1b-026719f701e3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a36450eb-db06-42a7-8d1b-026719f701e3;Ip=[146.201.107.145];Helo=[mailrelay03.its.fsu.edu]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT016.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P220MB0569
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

I decided to write you this proposal in good faith, believing that you will=
 not betray me. I have been in search of someone with the same last name of=
 our late customer and close friend of mine (Mr. Richard), heence I contact=
ed you Because both of you bear the same surname and coincidentally from th=
e same country, and I was pushed to contact you and see how best we can ass=
ist each other. Meanwhile I am Mr. Fred Gamba, a reputable banker here in A=
ccra Ghana.

On the 15 January 2009, the young millionaire (Mr. Richard) a citizen of yo=
ur country and Crude Oil dealer made a fixed deposit with my bank for 60 ca=
lendar months, valued at US $ 6,500,000.00 (Six Million, Five Hundred Thous=
and US Dollars) and The mature date for this deposit contract was on 15th o=
f January, 2015. But sadly he was among the death victims in the 03 March 2=
011, Earthquake disaster in Japan that killed over 20,000 people including =
him. Because he was in Japan on a business trip and that was how he met his=
 end.

My bank management is yet to know about his death, but I knew about it beca=
use he was my friend and I am his Account Relationship Officer, and he did =
not mention any Next of Kin / Heir when the account was opened, because he =
was not married and no children. Last week my Bank Management reminded me a=
gain requested that Mr. Richard should give instructions on what to do abou=
t his funds, if to renew the contract or not.

I know this will happen and that is why I have been looking for a means to =
handle the situation, because if my Bank Directors happens to know that he =
is dead and do not have any Heir, they will take the funds for their person=
al use, That is why I am seeking your co-operation to present you as the Ne=
xt of Kin / Heir to the account, since you bear same last name with the dec=
eased customer.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law okay. So It's =
better that we claim the money, than allowing the Bank Directors to take it=
, they are rich already. I am not a greedy person, so I am suggesting we sh=
are the funds in this ratio, 50% 50, ie equal.

Let me know your mind on this and please do treat this information highly c=
onfidential.

I will review further information to you as soon as I receive your
positive response.

Have a nice day and I anticipating your communication.

With Regards,
Fred Gamba.
