Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9162A461050
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbhK2IoL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Nov 2021 03:44:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13970 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349380AbhK2ImL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Nov 2021 03:42:11 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT85AZ4029607;
        Mon, 29 Nov 2021 08:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Y9uTo5NM5DEmJo3Q2jDzx/0FBOBwXd5j8JCn0QoGPsw=;
 b=qXpvC26UFk0y3hgPJ8e/u6uBNTaUrTJTRUFZTDsK0tWQg8lyuHJZiDnuc8v4RsHRClNM
 GwCuxsiOzip1Y2mnUHxZ0TAn7RqY+plnXHAra+zLagn9t6BgRPo7OcxAnjXNTvOyLW8J
 0nYwqCVnGUmeNSZUbYKy7L8CsuDf4zKD0oZkMfaGl2QGjryvae903Fu42jNZgIvncz8k
 vgOLVp8UCzRwNlCljbbPOoCPvXDBSzImORPOw2G3yKvbCpla7q3+fyFCzUq7QH+IP6Lz
 FQNEhOUSFEqRRLMbJQbwV5ZTFd2foP/Qai1u2aVHqHLIrN8AzQ48awud77NjfZg17FL5 dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1w85f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 08:38:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8Zdh6082321;
        Mon, 29 Nov 2021 08:38:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3020.oracle.com with ESMTP id 3cmmumpugc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 08:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQc6+Rq4QJ81g30z+IrHxfiIBXpmHy/6c0iXiXpVeIdTG30q0kvwDfQo7kvFxmSanel1UkuqxLFm4kOJFgKSyIDzL/5f18kVxyeCtd7nk6fZyWsGDBdm20enkik+GsZB90k0xPMxXtZ4yWz/y0ph6G+8RSixfUevZ0fAtRPclb7+gNV7ya6r/Ae4tg9ZZ/mbYGyOzuHsX/ZhTpAyy0BoU+GTD5+EfmWs9bHD5vcuERb3yTJAJLwW+Ifpq12eSM3/TN/hP1JMLy+8v67g5GujGHgbTRXKnihxcXcPMTGUFCHmy/+nq6/AVgJG/04M+Q3oi3gND3G6ReEJV3R3Uychng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9uTo5NM5DEmJo3Q2jDzx/0FBOBwXd5j8JCn0QoGPsw=;
 b=ThypSPUH+3lLuX5DE0gsXBCkxfhJ8mcA7QxsCEXcQQS8KBMRcK3VupnvQMBF0VzkwcSe2bq2+20j1nY+xLU0aUbixAvA7FB5BkeAlM1QNN/d9ozgB8onQDgM9aZlKImHK05h03ux51kXZzJ5GIFJxd0rS0h5Zz5xU4BbRceia8BCEb/6miFCzUHxDERIwxTnzzr0b39YZN4GBK8EpI9mqb0pX8GodC3oYv+5D/RNK7hKnyTCB1zjprJsdkKn88gkw+iaze8a+pB7JNd/BJ43qOIy55jcGabHOcYy3FpEc2VG8pnFX6s8TZ0/gZ01j4I91UxIxSgYuImg4Qk4GJu/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9uTo5NM5DEmJo3Q2jDzx/0FBOBwXd5j8JCn0QoGPsw=;
 b=QOKAUHC8/1KY4iMlQ0KSBbsm02ZjB5dtaPYFCXUHGANYMb9DMB4DeAuv4l1CG6lD7FycSEHgV9hFvQvZF/isz6mCFYMcNC4Q9tkSNtGJVA0qNZEPTfKzkWMdDA4hnCmn7jvisIrb8KgeCeDZ9KU/x7KFFL7ZRYik7l7Z5Rgr1lg=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5727.namprd10.prod.outlook.com
 (2603:10b6:303:18d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Mon, 29 Nov
 2021 08:38:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:38:43 +0000
Date:   Mon, 29 Nov 2021 11:38:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] mailbox: pcc: Move bulk of PCCT parsing into
 pcc_mbox_probe
Message-ID: <20211129083832.GA31721@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 08:38:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe019404-1583-4f11-d0ad-08d9b313a6dc
X-MS-TrafficTypeDiagnostic: MW4PR10MB5727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR10MB5727DFF2C1A5083FB2D8BB4B8E669@MW4PR10MB5727.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqPQzEDjTXZD0i8iEbBQdzRHyoh5f/yec+dnzzawjseg5k3ki2yKpGcc3a2tENQTdd72YqU5QhOkBXXalzK75GY4xtCDDaFJgPnGwXZO8ERfrvlbFgaPR0K1rajSQO+gAluRhr+Y00dtgJg7nhTInJyjSSJdTBFQZgQWTLLS/eZRMqJltO/WMC2DWQX4irC4com+5z7GoxRtq6mif+LmDdI0+MgraJh537WrUGIlC5tKqP9tzZySMHneWUHy0/A/kLpG1NWDdTZjOr+pYkJpLGcQ268n54hxdju2kUE0SuIqDkF+ERJnyuEAd/5QB2/1P/BWY+PFpIlcCT5JK0eqHyZQ8BHDaZ+E1FGGzQzk5qH0zjY/bG4v/zICHSa/TK8Fw9KCWAJ1tkeAHKihIqvcJLxaVWnydsE7nYSpWM3/9wOyZFkjo+XkujhSIgRkiw723Fex/5bsAVxPfXtpPwhIGzHcd5t5LxJZvj1Pr1WIk5H3dPOvgWgB9FgO7J24z4Hg32XI0pcigikixPUI8g/d9vqzr6G4yAWBJdsI5QSatYedqmW6roKxgOLJhPlPIbaxOQRFTO2VFlXRUQocO4u5eJv0Lk3gKXfZSu/FOoDlHThh44o8JP2tlMB//uDWXI5g9eJb+vQGdvOLSdB/Ok4l4br01aUwv2J3No+gx0VxlOHvlq+OMjU+bbtX1D51sOfdBJGAAZZ3zVuGkanxnN7LWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(1076003)(6496006)(52116002)(26005)(186003)(956004)(2906002)(66476007)(316002)(9686003)(83380400001)(38350700002)(33716001)(38100700002)(33656002)(66556008)(66946007)(15650500001)(44832011)(508600001)(4326008)(9576002)(8676002)(86362001)(6916009)(6666004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZK2Rl/oT2IdtznqRDWGM0H+VgE/4N21xRUo5OrhOTr/BH/6ofL0UofiLfI2?=
 =?us-ascii?Q?lqRa/79jYIWdQLB+UO8Nvycvm5r5Ik3aU5aFYZ12sMOnObVFkQX3Eahi1vPT?=
 =?us-ascii?Q?iNehwvpjyB6d+aD7a5AEOcJ6r1cZpDrf44ZEkZLG/Hs4lDmeccx+oKVx+64S?=
 =?us-ascii?Q?kMRCuq3dZWaahV4QnLo/q1juDSFjDSW4V2gJ/TT0CUdSn6GCIApZivfmygd4?=
 =?us-ascii?Q?MRD4CiT8OtqdKXiGLCNaeBPXL3f9bW2rhSCkwsFJwJH/k6QLlNf3eaIHfthT?=
 =?us-ascii?Q?4OjaAVbP88xS2L3ShZriYkZWHVy2xGiJaE3L20zK2sjpwICiXHZ1hZSC8mL6?=
 =?us-ascii?Q?52EDdMh397FkAK7LsfM8phMkp4UDcRGJs6I9OY26YimH1/9/bYAe7bVlJiaB?=
 =?us-ascii?Q?1PZP5jRF5B708ehRNoa/Xdb8+99nyjVu2UFYpSLHeUFhhES1P97R5RNKrnK6?=
 =?us-ascii?Q?fIPdntBd7/zwNJW3k4pP23x+DWWo9AL7+9/Tzig/t7yJQC1dVIgxtFzicjiJ?=
 =?us-ascii?Q?Z0fkRg3vPKyLbucN7ifNbo7yUhBxm7JLOxurMUNqPg6RzxsN/e44DA1s6unp?=
 =?us-ascii?Q?OVp1joovWY6qRFl3X6/n/J+3nIx390dgK6oVl+SI0S1itQYJwFRCbXHn795Q?=
 =?us-ascii?Q?ekOz5un5UIqyj3uVlm9lG+Ehr8OyK3G89vXvAf8DuF+w8tv5a7pi/dJVxcP4?=
 =?us-ascii?Q?s/WI2b8LOX42towVt37HtIrg4RlD5Rkya8/9eACk5foIfbsJZBiw12h71Q9Z?=
 =?us-ascii?Q?GYmyy4ckkQ6xYx8XSCfmNXu8zkc7/C6E0b7C0zhcFK71Q/tu4vtaXeRrK0GP?=
 =?us-ascii?Q?FcCNM2JIgf/7B3JpkiLHCL/CCRBlF8DfrQm5ZHH1mMRH6urP83e9pk+t2HOj?=
 =?us-ascii?Q?PNrHzwxmEZVvR7mLoofo+JZFJU7O9EfaHtyPGujWZomMlfAIZfgWa19bxye+?=
 =?us-ascii?Q?IX2NX8V5W9Z+ujjIvUteKRvR8ZBeckZlv0eWlzkmZknwbix7Uq5hyvhel/Bk?=
 =?us-ascii?Q?xnSB9gqoE0M4uVhR1BxZN3twIQZfgUCboudiJ1aV316F8DjhoeeKts6wN1Rb?=
 =?us-ascii?Q?hyMGLSwU1F6AM3zm4x3BTipPG5sh5heZSRAc6tZDy8FGeVbFj5ejTYxL78Pe?=
 =?us-ascii?Q?ukVfewsjum5PW4XT4qK0edpfJFmEs9txecY2APPCc7+IEqckuAZ3nuppCF1Y?=
 =?us-ascii?Q?KalU/5p4uJrYqY4OOn/xoSDVdTsGx3RAfHka603Ez26DF2nuQoexvAlS+iNB?=
 =?us-ascii?Q?W5C8HLFWATsanbq5WtU48BirUAO0RnRX9eMPbEydwzaFGdalzYl8dttmSjHH?=
 =?us-ascii?Q?MLXJKbZo8ThAj8Z2e4NTPDT3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe019404-1583-4f11-d0ad-08d9b313a6dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:38:43.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucsESSad2TZHsRji2CMm7JJQ6g3OmbXoy18Q4VYqF0uraO7jCg9H7Hc0U5/NBVtEi8wwD62QqD+eZhkH9UaXi2BP5mj2NARvVyP5IY2d4Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=724 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290042
X-Proofpoint-GUID: 3zN-JsM0Ob4jzyEHZ3OofpiWkB7oTgkt
X-Proofpoint-ORIG-GUID: 3zN-JsM0Ob4jzyEHZ3OofpiWkB7oTgkt
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Sudeep Holla,

The patch ce028702ddbc: "mailbox: pcc: Move bulk of PCCT parsing into
pcc_mbox_probe" from Sep 17, 2021, leads to the following Smatch
static checker warning:

	drivers/mailbox/pcc.c:292 pcc_mbox_request_channel()
	error: uninitialized symbol 'dev'.

drivers/mailbox/pcc.c
    282         struct mbox_chan *chan;
    283         struct device *dev;
    284         unsigned long flags;
    285 
    286         if (subspace_id < 0 || subspace_id >= pcc_chan_count)
    287                 return ERR_PTR(-ENOENT);
    288 
    289         pchan = chan_info + subspace_id;
    290         chan = pchan->chan.mchan;
    291         if (IS_ERR(chan) || chan->cl) {
--> 292                 dev_err(dev, "Channel not found for idx: %d\n", subspace_id);
                                ^^^
"dev" is uninitialized.

    293                 return ERR_PTR(-EBUSY);
    294         }
    295         dev = chan->mbox->dev;
                ^^^^^^^^^^^^^^^^^^^^^^
Set here.

    296 
    297         spin_lock_irqsave(&chan->lock, flags);
    298         chan->msg_free = 0;
    299         chan->msg_count = 0;
    300         chan->active_req = NULL;
    301         chan->cl = cl;
    302         init_completion(&chan->tx_complete);
    303 
    304         if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
    305                 chan->txdone_method = TXDONE_BY_ACK;
    306 
    307         spin_unlock_irqrestore(&chan->lock, flags);
    308 
    309         if (pchan->plat_irq > 0) {
    310                 int rc;
    311 
    312                 rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
    313                                       MBOX_IRQ_NAME, chan);
    314                 if (unlikely(rc)) {
    315                         dev_err(dev, "failed to register PCC interrupt %d\n",
    316                                 pchan->plat_irq);
    317                         pcc_mbox_free_channel(&pchan->chan);
    318                         return ERR_PTR(rc);
    319                 }
    320         }
    321 
    322         return &pchan->chan;
    323 }

regards,
dan carpenter
