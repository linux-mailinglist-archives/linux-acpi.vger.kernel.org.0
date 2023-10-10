Return-Path: <linux-acpi+bounces-569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83A7C0381
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89A4281A9F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694632FE00
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Mq6TLbj3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753D225A3
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 18:11:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EC9D
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 11:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlDn77FWf8rTiNl9HEjv2umQ/Xt4tcyXFKd15seBCFATggS4zp6K5Im2reDs5kP3trS/FD9y3IMcPHMpF4eKnQgJjOa/8o7SdQdN29TXo6aroi8dNJcEaMpEYZFaHkMYNcjCpdjw0cnZcqmBEBi98rX1VVTlrQErshMQ++KGn4LTK+7IOf4rSrPE6r1LzB/LDBgCL+2QqZrIbS9ZqDeQ4XQhifPdbUjFM6qt2b3Q5gp0NrqJrOAu2RdNrD1OY0L73nbjERIuuoT6D+o0RIzXGIdWEJmIxN+S4QrUR+ZDWKwByB8DFxmywi2MDCYulMb/OpNG8+4+6fTJviFQ04SqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2YGcdcyiDehzZg+xQXZ+PxLZZOHyyOdZjgvhb0Z+uo=;
 b=Cx7CRNP/V9lsFFAnKkIVXUXscGDV/yxln10YWGvOx5h9ovZhNVUrnCPMx8clxmmNq/ZWCFn4+I4XcqdEjmeBzlLSOl2hK9yeNkYg5zlHJVnbb/h60brZflhUMOhOSYNfaf7vvkUV9FHrOFvKoRqBTBiIVc4BRDw8LrcCm17R6wYuaWol4vy/XY0UaFUIt515TzxCqNIBAC08f1s96z+X8Ui60R1PxuUR4M73aYK0dMH9D4UKajhDft2ETUu2Epl+X4XtRFqGbyKOATF2VifrqmAJQPLjx7UQ/HTVWR9VODxpSf/+HUdHk75e5M9OokeRBntIrfpw4z4wY/8pMiEqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2YGcdcyiDehzZg+xQXZ+PxLZZOHyyOdZjgvhb0Z+uo=;
 b=Mq6TLbj3NzFSZNIfw9U+bw7U17+ffjqWIStHyiIm9Bf2H+pJCjsYvObvKo9Rc3uiOF85U4vzPIAUb03eA0otbNKwkdyDmrLmz8QKn2htLIp2HpxxrQtDwfNZFYFlcGVMnyyVIPOoTuftmg4tY7pK091r0uVDMY1jsjUzyfN6G2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 MW4PR01MB6161.prod.exchangelabs.com (2603:10b6:303:77::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 18:11:05 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b04:8319:9c23:c3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b04:8319:9c23:c3%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 18:11:05 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Hanjun Guo <guohanjun@huawei.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun
 Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: bus: Move acpi_arm_init() to the place of after
 acpi_ghes_init()
In-Reply-To: <20231010082123.4167603-1-guohanjun@huawei.com>
References: <20231010082123.4167603-1-guohanjun@huawei.com>
Date: Tue, 10 Oct 2023 11:11:01 -0700
Message-ID: <864jiyqrey.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::28) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|MW4PR01MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 067a7155-0d73-4ee4-efa9-08dbc9bc44ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSfJX+kBysXFd2avqcxQwMgWpQ5ur/IK9P4T933yC656R9v5JrXiqNlGz0REl2ZsdmrKxv9zWjHrGX1Jqa1a7/i0BLJpnQR7zRkoFAiGbrBKkhCwsgt2piaB/UNPrc0khMvuTTOtunfCI/rgm2QNcsU4l2Xc3WwSLw8YP0f4ubldcNDKzdqJq85v24rDJuIsH82ybqIbv4+yjAqNgj0v9ouFpVh1OtuKDaR/8Z3mfbILsUH4R7ch6VUxiy8iASwPJa55gFvX2xMTnul8XN8U9Z8vgV+xoiDMbiYvAS4wleFw1t1m6VQ4oKGfyVYSzh3sUxJ5dv2wC7B57u/xbdYadaaDb7FZCIVhcldGCGh8wnOPE0MIesiQdTjrToKryIVH4Js7F0HBBw7I3SVMPpVWHVUJ+Rtu8cf23JIODPDbU10iayg7eiiSrBrh2uGZoeSIh4g1xqKKhYfYKdCBBEsZSG+F0XRruRvI2V75H2oG8+z3Wv0fjpkseSZqrRs4XRLlnKNVSV7ur6rokK//HKdYwghiydlONFxVrzbQfN33BA9Z4ZbiN+33GyVtYH45qqvnbcqqWKQN2Zd0nM7IAMCCsyQKAGavS41sIrDjJfpbkZyQJVkk+Zz9yjoteBl1X8WH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39850400004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6486002)(52116002)(6512007)(8936002)(8676002)(38350700002)(26005)(9686003)(6506007)(6666004)(4326008)(38100700002)(478600001)(83380400001)(316002)(86362001)(5660300002)(2906002)(41300700001)(110136005)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S18gU90/zv+w7CcCWoZUoNTV2s3BiRax24XxIS5oz2XYnpRWaMCC4sG6diDs?=
 =?us-ascii?Q?IA269dDaZq9iSEfzlTOC8FpDCm4H9il7XnCkyGQ4CREtr7FrbetmbRbOFO2j?=
 =?us-ascii?Q?hJ0XESX20VxarPhBWjZJd/luj5ykVyOCnncz2pBvDrAQZ1KDq2muRUy2XWr9?=
 =?us-ascii?Q?nvGbDK/ivjcuY8PfjFb7DYzIxe3qm05SvmbDdSJg5giOL0lYvBce/lqQLGRD?=
 =?us-ascii?Q?w7CURQQ4rmyVdqVgwv1Or68ziDMriArrEQFkmdm/RQVLF/GL9pg6IRAaMwTS?=
 =?us-ascii?Q?omlAQD4ZiMPSaVjK9M/12JPDHG0OdJ1Z9QU/U2URbPK7zimJ4DU973ntQNr0?=
 =?us-ascii?Q?qVGisR52XyMiGCF/L1/hcfZ7Fm/yCkARnEAzN+EZcGRcTEyHzoWGzGKRa6U1?=
 =?us-ascii?Q?rY79kW0TwmgS0wvKMMS9v+SwTFW8V7RgpTHlCi2Hv6X12FWyk3wHep2IGNTL?=
 =?us-ascii?Q?Ay1Z5tcnATX4O73UumFm61AaGqwY0msrB053pesER3QPCCSnSD9dQmUg/PBR?=
 =?us-ascii?Q?/FibA9jyoIRpSZZXuqbHH/oc0mrET+61Pqvo/6BHzW6Ni6orDClDTaORgL4y?=
 =?us-ascii?Q?w+Z5xXDwzvg7PnDxqQhGDwSBcMB2WJUXvgJ7acJmcv2ot1NntI70ZkfF7snq?=
 =?us-ascii?Q?k7DCpi+y82JZ5gc2lHx084wNeVYezuatiE35Zaw8lmrw+emLu7DgaVmIFQ9V?=
 =?us-ascii?Q?yYEJFXBHaxHbvwH9JOxo261ZGo9ghDHxmLI67uSyJbPJbTkjl+EAfUIl/3Bm?=
 =?us-ascii?Q?1bULtZQPGUZlpKUZ2US92oOmDKnCoFQOOTUIDkR+VDbR9W3zxFGRElMHRGia?=
 =?us-ascii?Q?tL03+tXWyiqgxQqtVfWdEdvu8VwBqDcE+Cgx+dlfIbOlbBSHxgg+NoBbiGlN?=
 =?us-ascii?Q?v6DoCfYL2FA9AVO8eaG38wtY+0jBHu2wIt7gA8GjMvOgB3tu1USdQMWBCIId?=
 =?us-ascii?Q?mr6uoi/km8kuvSkUCsEfP34go1Mcj/kU0Oo3ZINH88wqliJOCrBEMqEbB2hp?=
 =?us-ascii?Q?vqaFD2ty3Gz8lRrpwlI7H6Otid0qHZGtetWoqja4jalapZdnHyTJL4K0nG81?=
 =?us-ascii?Q?XfAF9rzirC3Uru7ctICz7ZtZwEduwWbLTFpBaJQyjNpLrBO43GRJTLzQMO+A?=
 =?us-ascii?Q?34omcuMYOxF3f/CMsXgFk3A2xisrv2gvRB9YW/E0vq5jGXxneP8TjtMPzVWP?=
 =?us-ascii?Q?VP/vmO4J8O9ZzFZDJeEH+nLkOUEbbg1ZPdqMSW8Wfe8vUhu8qeSSLwL7wWlg?=
 =?us-ascii?Q?TATon0HRJcZvcy+JnC2230cEg8Q7T5wiMA6KVanEBiKVX+vgzkUlEWt773Bt?=
 =?us-ascii?Q?xfZXhobznQj3YXYZvtz6LlgR4SxQucVnKd4fdizBDnQj7OP5Gya2+/YxjeSL?=
 =?us-ascii?Q?9iVpC9t5v6MNk0a/8PjqtEIoH1XzH17pOgkMVTGX0tCcx7a79aDUtafabDXX?=
 =?us-ascii?Q?LJyar+Bhp0Gfc++REUE4qCSsIgfiFjzVofz0VREEC4s5ivFUrlpa1q8miEbL?=
 =?us-ascii?Q?c189Sc21oIaUds3At7xCduwEL0npVvuqQpQzGvapXCf83p/+hR8+6/6JpmQ1?=
 =?us-ascii?Q?pr4dt0aazWiQjd+gZkmixq4PsB5hBrFliMRb4kSATy/3CV+dsSyQ8LMqyilt?=
 =?us-ascii?Q?osE6jhf4wZLTYikG4fv4QPQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a7155-0d73-4ee4-efa9-08dbc9bc44ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 18:11:05.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZG4Ng2DHHm8AzdvG4Iu9ngn2Ps9NPAqUnz+VhorwwgjBvkUmSzzBy1nJG3LFjYco8ArFpt+oo5gsKRKoDOXii5zuLfygZ0yyr079G4F8NrN/4e4cz/rC9P6vmha1U76V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hanjun Guo <guohanjun@huawei.com> writes:

> acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
> it needs the SDEI subsystem to be initialized (which is done in
> acpi_ghes_init()) before the AGDI driver probing.
>
> In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> initialisation into acpi_arm_init()"), the acpi_agdi_init() was
> called before acpi_ghes_init() and it causes following failure:
>
> | [    0.515864] sdei: Failed to create event 1073741825: -5
> | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
> | [    0.515867] agdi: probe of agdi.0 failed with error -5
> | ...
> | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.
>
> Fix it by moving acpi_arm_init() to the place of after
> acpi_ghes_init().
>
> Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()")
> Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Tested-by: D Scott Phillips <scott@os.amperecomputing.com>

Thanks Hanjun and Sudeep

