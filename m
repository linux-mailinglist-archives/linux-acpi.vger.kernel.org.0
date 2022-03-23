Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17694E4D7A
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 08:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiCWHjx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiCWHjw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 03:39:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2087.outbound.protection.outlook.com [40.92.107.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB042A02
        for <linux-acpi@vger.kernel.org>; Wed, 23 Mar 2022 00:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq7qxu+hCBCIXaZcvIf82n5hW02xHE3jtkZYo/zI25t9LVabmapHDWA47Ra5n64vTl3rVsw64ysJ98nHs/Hxre13laGhI2Nhnofz21Y1NpBAr0oLFOxIbDNS0K5uPLb40hvPBzt04x2yUy6jXC07dCCLWXJzpnpnzO06xEqQgI6l/w5GKYMzjNtZDmBI3gYvsx7XaN677edfKGZsUlrzpjJ1JJ+w6YfE12eb3T26QQeCQgOkYyxxYUPqFB3/0krlSapTNni9faKUuIxETOwLgsN+uv+B5InldyuiQNqmtEgBj+iMmZBRimGbQvt4dRRSwAvkedXG1KH4wYshZpy4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngXAVACUU35zRyC3PwPfE4GuJsc0tg9+KF24fn1SgFk=;
 b=mbM3CA8HUuOa2kJGqzhaNuzHxl6H36Ger4jSGbJC7KAfCPsNAD3l7tbc9DgNPAF0PGy7q/FozvXgzF/EJ+rUnbkCCdHab76l5OukhJ3JjXdeKlUu/hCyCZiH44cGNFZrGMYv2e2nxTlDSnvdVxuaHVogIDJn/IgqNRPiJjRXGhga48z/OUzzqRKWuwkbRIdQmYn88Xnam6Lzb2Q1apJI9DcUAfsy8OtF4OjTjSPjRI/wcB196GkR92ZjRuZl5StkggF2bvCz0g4at3p3hAmF4AoUlbwXZBx3b9WLulkTTGDJNG+qUNi+QjZBXahZ3hFKyLTFSmYkqgXXv0dteZ+Xyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngXAVACUU35zRyC3PwPfE4GuJsc0tg9+KF24fn1SgFk=;
 b=l6Hmvvw3LGjXlMr3tEelBeNnw+z23yYmc3TuiEXik2oFXeBqwhfBRLApAplNpZ/gvuHL+7oKmvVUPbsElez7syDPGM3FQICENsTBr0IUYD1KAr31BUuGYCqZJGYH8+myR00+InQyhQydDYjQPDKNEMod5MBeK9qBVFGjJ9dOmdNkkwoeitI9pd109cFHRo/0DXCCG1GopSsSuAc4brKtdaPgUCEtpCL2pNlVbE8Tt5T0YL250HtvMBhL4CNx1len1JAPsfKLNxnj3VeD3IelNAYBlu4Yj3IP3p9aKi8BXiVXt90vADKN7H9DLSasVssiRHfhvroJYsKmCdT2hbz8OQ==
Received: from SG2PR06MB2747.apcprd06.prod.outlook.com (2603:1096:4:1d::19) by
 TYAPR06MB2176.apcprd06.prod.outlook.com (2603:1096:404:19::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Wed, 23 Mar 2022 07:38:20 +0000
Received: from SG2PR06MB2747.apcprd06.prod.outlook.com
 ([fe80::adf8:6046:9ccc:b97f]) by SG2PR06MB2747.apcprd06.prod.outlook.com
 ([fe80::adf8:6046:9ccc:b97f%6]) with mapi id 15.20.5081.017; Wed, 23 Mar 2022
 07:38:20 +0000
X-Mailer: giLmiaR 61
From:   "=?gb18030?Q?=C7=C7=D4=E6=BA=F3=CE=B9=C3=B1=B3=E8=B5=F9=D1=AF=C8=CF=BE=B0=CD=C8=BC=DD=B6=E4=B6=C5=C7=B7=B6=A1=C3=E7?=" 
        <ozqxoadmq@hotmail.com>
To:     "=?gb18030?Q?linux-acpi?=" <linux-acpi@vger.kernel.org>
Subject: =?gb18030?Q?_=C6=D7=E0=CC=D7=A8=D3=C3`=EE=A9130.=A3=B8=A3=B004=A1=A26431+v=D0=C5linux-acpi?=
Message-ID: <SG2PR06MB27478F182DBEC6C6AA065C4FA5189@SG2PR06MB2747.apcprd06.prod.outlook.com>
Date:   Wed, 23 Mar 2022 15:38:04 +0800
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
X-TMN:  [dddabGEfK5qSkyMzYpyZHecCVIvUaF2r]
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To SG2PR06MB2747.apcprd06.prod.outlook.com
 (2603:1096:4:1d::19)
X-Microsoft-Original-Message-ID: <c098f231c04c409329d9ce7031e821a6@hotmail.com>
Importance: low
X-Priority: 5
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf021fd4-d9bf-4769-2265-08da0ca019c5
X-MS-TrafficTypeDiagnostic: TYAPR06MB2176:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VU1fkvt5QmjjX3P+LfdT5SH24T9QiGX224Uss3i1BK7RrsHGIIHwRtR06XTQIPWKu570N0WKlnLtFfv5aalhtJME+PDv3aH8UcuqGSihArtlmm675vgaNPWLiIUwoDhEW2k3RjhwitctfOPv5JUv4s14rffO/eRHPxKJHR4SSNJMX/lfD81s4yWcWWXtJfm18savL+G6qjiwDJYK7ZNznXBc/kEVyk1ACXWqzRG8ijivNbf+FRnfRqNAqP0s9B1mVpeqRd48sbOAKwd92w8cu/83VbA8SQjCDaKZxF7j92hXrJR85q0FITXASAO6TcWZkSJuxVmDAcOQhXjFN9Iv+pvc+qgz8HHcaZ3ClAR518iclu8ZY21FasdyRIHFJK3ULf6FiklaiE03jui6o45MmiK1Fn+/L2pDVw5kweS+JFCDD+wmWet5AI7qAZ6MecM0jREd2tcMOF1AdTJFrWCExMNDFO26szu4JEkg5/FyoaE6Ls5voV2Ana6MKsZnbZkdKOzTLflc2fIKm5gAAxyM/Bjtf9svKtqvD1ozyHlPJp9EUZVzNqVo5XfUV2gMRsGfWct7SiDcdSMJZTyfuOB4g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?GB18030?B?L09UL2EwSGJSOEd2dmdnRWVmVEhncnJEY3ZJQ1RBYmd0amx4MkNydHdVVUhW?=
 =?GB18030?B?akVsWFlIdlo5RlZ3M1VaalZPK1pFNVBTS0hsM3p4eGlobkVxalU4NDQxcXVq?=
 =?GB18030?B?MzF5ZGJUQnRPNmdkL0hpckxEelNQMk1yOEhaY0FKWDlOTFNPVVd5UWZPOTdo?=
 =?GB18030?B?cUhTeDQ2SGJvQ3RmN0xIVHZoVTM3QStaSUs2cDhzSEx2QlFlZ05vcFVTcHhp?=
 =?GB18030?B?ZkpaNHVIQmIzb0JXbHlNaURtSG4walpSYXJETTJiTkJNUFlSZVFXSE9yVC9z?=
 =?GB18030?B?b1dUN24xR09CQm5lNkNwamZ5U3B2UkxFZ1MyQjdRVHd5VUJNM0pvVFlyTGdW?=
 =?GB18030?B?U0RBSjc4N1IrS0ZpSkRORU1pdXpCLzlnY2UrWkc1OUpROUxaVlQwaFk5S1Rs?=
 =?GB18030?B?MGcycVhDVFhsWXgwUnN1c3dUZjMwSUVWUi9UNnM4eEUweG1EQm1SQk9SNUZw?=
 =?GB18030?B?TU94eHNzSEdJN2ZHczBpUElaczBwWjFlQ0VHSGc3RXBvMkpNVE9KRUFBaXA1?=
 =?GB18030?B?bS9FR0E4Y3YxZ1czTU9wSy9SWnAwSmZyMHJQZkZZK25EQW5STzl6Yjd5SlNF?=
 =?GB18030?B?Vy9yd0hlRktHZ2U3TGlSOTRxRnBRcm5maUpwNnQraGNWNmRWZk5nT2IvcWph?=
 =?GB18030?B?QlJ4Z1BZblRmTnRQSmE0dlFzbTFFc0V4Sm5oT3JJWmhQaThGM0NCOFYrNHZz?=
 =?GB18030?B?TUh2ZEthSDNGY0RKK2ROZ2t3QllxWnpWQlVWbzViOTlWTDRUbW1ad0h5L0Uy?=
 =?GB18030?B?S3JVN0Q3MmlkOXZQY2NyOEZZQnFBQ1VoT1I5azh0NHRaN3B1YVFtMExvUnQ3?=
 =?GB18030?B?OWt6S3RSR1JtWFBQMUQxZzd2c1krcjRHN1hJQzdKMUoxWFgyUGc3UWJYemJh?=
 =?GB18030?B?K2JZN25sS0Q3ZVR5YU5wNWVMTERFWi94T0RPNmRqTWZxSXZZSjdZcFpnOXhv?=
 =?GB18030?B?bXFUejc4OW9qcmpwUDZPaHlCOHJGcW45UE5FUG13b0VRTmpMdE5qc0dWSnRN?=
 =?GB18030?B?cTRlcXliaFpabjllNzlNR2Y3TDFXa0s4NEQzSHF3Z0daWDA2TE5VTlVuZEZn?=
 =?GB18030?B?OS9MQzd1dlNpV2NBUHJzUXZiTEVBczhjZEJqV3B5V2tCVGtTd0VRUG1ZM21L?=
 =?GB18030?B?bnZFRmpydk1vSm8wMjJsU0MzaUQ3SUlCU2h2MWRGdWRQSk1UUzErdVpoU0VC?=
 =?GB18030?B?NTVVVEhoaGo0VTBNMnh3KzFzMWkzVHd0RWNZcHY2OFRMektpM2NrR0hubElu?=
 =?GB18030?B?d2drMHErVVc5VVRoWFo0c1hKZk1aQXB0TnRZV05PVXludUtDWkpxTG02bzFM?=
 =?GB18030?B?SkRYM2RTa2FMd2NvQ2N3Y21pNElEdWVmQjZHVFBRNkV0MzIrbzlwZ1h5T0s2?=
 =?GB18030?B?c1JWNnpxS3dvQmlHQXVoK2NKTTRzTjdCT29ud0ZwVHNSRit5dmt2WGg1UWdl?=
 =?GB18030?B?eDE1LzlMdlJtclV1dzNqbWpLRFFPRWZoQmhxQmFzWmZ0dnk2WExBZ1JyWWt3?=
 =?GB18030?B?RlpId0dVOVFtOXVZQlZFOGxGRGpOZnRjWDl0Zjc4ZTlEQWNudGJUeHJHcTZs?=
 =?GB18030?B?MHJZQT09?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cf021fd4-d9bf-4769-2265-08da0ca019c5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:38:20.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQo+saPV5iC3osavMTMwo944MDCjtKO7NqO0MzErdtDFIGFtZSXN9b6twO1neDFwRyA=
