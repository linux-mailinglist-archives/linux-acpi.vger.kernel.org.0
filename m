Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3F52E542
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbiETGtK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiETGtI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:49:08 -0400
X-Greylist: delayed 9150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 23:49:05 PDT
Received: from CN01-SHA-obe.outbound.protection.partner.outlook.cn (mail-shahn0098.outbound.protection.partner.outlook.cn [42.159.164.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4814CDDF;
        Thu, 19 May 2022 23:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAOvedem4fUzTZBCK/2EQnOL1xA4BCPOnWvqqSQ+8yrsXIuti7nSQ9Cjrnwn+I4Sp33awWFo52/n2yC+7mETXaRQWa5QPQ29sZXBJqywfCTTjldy1fRD9ZiItGK/zBmVq7Yn0dmmzn/kIdZBEaz2kOSldEHgCkK6+B6+PQQ2iCrUJYV+yW19PLj588bzAqs3ynKHlSvmREz7/MScnJYR0+FmW48sxxvc7537Y/OO63Mry7Ef0pmNhQ4h+Sfmm9Nq1ZhuyxkVUySG+SkP2ooTAFxBg5BQuEG815adQT9wZfJ3fz+f5vMARp9KekskZFqPwUb5itgbEEMQmNWTv4KV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=oKaNEp9gZ6vtAeF24Y0ntfrZumFGInkPTONGHLA1vssssX9g4OZp7ZJbpQzG7J5Nc6ppOmivj0itENA4AJXw9EqYFppdSSmmb1/wyCAk40yeboYVPtPJhwOePwJgZAZnH4nPTcvdeAsUVLp5L7Ejz8z5j8Us20JFdvtWB9eQ7cod+FGEjD8eyaQvXpu5XTB39aGb/R4sdLqYrmCPW1e4bLjtbfR9etGjmTXUrtzOvwY2UcNgvAnJ3vZa5w9ob1DITTzb+oqpfhcVTwu3F5I4dpnA17a6ZUTCBvwjyVZfRPYor+cJ0l8qPLHwgXAC5s1tD5+Yd/H3DEWLKOUu9PszNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=JP6G2u0NcENGSJVupgr76ZzbYyRJZaEg903++4EaApwO2CuS6Auzqxi7PQ9YGGgxEwkb85zUPEBO4fL02JUkkBECZgmjcS8S+uY8hyD0fgqO09YK4eyc4V2hO49eUXej/HzXAhDW6rYJneZN4GShXuHKyHbtzh/xKo7CYlZpNGhi1SVfX95cKJ+sXARJCZLVRIOgNrDSv15DKRo2WOf1IxYMPsVQftq+aAOCX3oh5t1BsHN5Q+b5sjJ9VfEawha+P00HzH12uh7/7o9EdOR+7Z9vcTdnRpwxr09j4PBFYGyvxS1815icitBK4ArYitxK1AKOtONPCYkPvDvB5Shx9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0688.CHNPR01.prod.partner.outlook.cn (10.43.107.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 04:16:32 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:16:32 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:00 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (10.43.34.152) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB062322F93C167DC3764EDCD689D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d65ea2f-d34f-4d4e-7392-08da39141469
X-MS-TrafficTypeDiagnostic: SHXPR01MB0688:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB068891EA313CA4CD764EBA9689D39@SHXPR01MB0688.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bZhPxEvYR2ekI4UbniL4wBcd41myLAKAKxhdxyksivhkYhTZKSUq+KBc1p?=
 =?iso-8859-1?Q?2OWVgAF6t8KbLhUbvNdwn2ufFOctdE5OBLU0es4jJ37p7Y0TjOxYUeBkRQ?=
 =?iso-8859-1?Q?2Rn29VStFjnUIhtkXhax5KoIK/qm1f/AjNlqXzqy8Nbp4aygXzLnQCOMDh?=
 =?iso-8859-1?Q?yJQte0mjSgI7XFwZ6ib/qfPb+0FeF7K1c5RJMLeH5QNVW82Ae/tFf/kmIH?=
 =?iso-8859-1?Q?b5l9CXR08iVATmCjw48pMSQlM1wjsqz4Ejd7vhuYqpfU36wj56gD2nDTpw?=
 =?iso-8859-1?Q?fpL0cHScqEOgBe+p1n+Jn3OwfDEXDKXgMstlCpBH3dAGkJPG5xcJh0Ms7D?=
 =?iso-8859-1?Q?CJ9/WOFNqACYOLz42ZnyYIdm1zrm4rI9GPyAsUIKW0qcWQmQgiHe1rZ+2L?=
 =?iso-8859-1?Q?ot9ueafC/l46BvxlzttxABxVmQsvft+4LB+bhPa+5sE9vVBnshdtxp1ZtL?=
 =?iso-8859-1?Q?cLZEKxPQmMeIE3KlaFRzEfC2idbxgfmCa0ZXn5EmVnNpx0t/z+Tw6QRi1e?=
 =?iso-8859-1?Q?cwAu8rxCiOIqI+8Hs5ViVGlhdLXCe8s1myo85ObMj6c73wVVTmhAQPbsPu?=
 =?iso-8859-1?Q?/M0an/AVKpKhEca55EoV7PAIX4hpnXP2GqFK/uDbvGZla2lkqTxktUJL4T?=
 =?iso-8859-1?Q?ekxx1US97Nyh1kY2h78EPXCFeW6/e+sRVS0iId6iomDvmVk67tVNg7USzj?=
 =?iso-8859-1?Q?MvdZguOMkUtE++W6CBDuCPMeJHEHPe+dKbXLJ0iV/TO/D7S4y6/Qc9So1a?=
 =?iso-8859-1?Q?IFK4H8bZyTHJwEktmdcsM9WnjLjQOclATZI9skPAAxq+q8tTbPb1qpM5MD?=
 =?iso-8859-1?Q?618b8rM8Tza7cB9mOtQpxa/imeEkn7VxiSkCtQTDHqhX8DRN8pxt+oG+dC?=
 =?iso-8859-1?Q?DfelsjSIbglUyxiDxOraP5uA26BAL2Px/5M1zi13gYAkqO+y03qNCGnsHi?=
 =?iso-8859-1?Q?7oBAHITzOOElmbCDfrNnaUL0F9JelEemiaTx2nmO/fP9x6aaOHFyYjSo8b?=
 =?iso-8859-1?Q?+ysRvsCl+IcAZgSQFr82K7X4wK01293mPvXzz4di7nIu+vSOZLrl60RMNs?=
 =?iso-8859-1?Q?sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(6200100001)(19618925003)(52116002)(508600001)(9686003)(6666004)(7696005)(26005)(8936002)(7406005)(7416002)(7116003)(8676002)(558084003)(40180700001)(33656002)(7366002)(86362001)(6862004)(3480700007)(38100700002)(38350700002)(66946007)(66556008)(66476007)(4270600006)(186003)(40160700002)(55016003)(2906002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UGY+mR7Wu+IYeW2chcs3fe+gAQNk24z4EyOHOd4Y/v7ChhwtyQmB52LAY8?=
 =?iso-8859-1?Q?zisOiS7mf1RPPxjC4XV0wwZTiQa+EelshouAgS37+N1xrEfoN4YVKnoH9t?=
 =?iso-8859-1?Q?Qh6g8V/JGDpVFP+WgT/8Fj5wUPweUOoxbV+jngSL4Do4mCls+OVewfz05T?=
 =?iso-8859-1?Q?W2Om4yppauoSAEECcgQIxTle/GM1fmR9bDb50ZNpBscjaCi8RyWpzsJNwW?=
 =?iso-8859-1?Q?mI7adG2bYdQoeiioPgO2VWZMrIY3hmhPRMipnkC8pJBI2riGMCl58yYroz?=
 =?iso-8859-1?Q?ERG3R8O2OL/ysp39AekZW3qIPYZ9ANxLNSvdT+5sjtSJjp3aAaJBL9dysu?=
 =?iso-8859-1?Q?0psEC2R56NgJl0f5OxZJeQEcnVVdt2SyEQLscS09Z6+Lw3pDnjvfhVftZo?=
 =?iso-8859-1?Q?GYJ7LdPBMvgho4rwv5lyCpZUTuveQtq39hFV8iPfAC6aXAbvsjJGJgE4nQ?=
 =?iso-8859-1?Q?JMsBH4UkrsxAlqIYzWY8TC5cNn+gWYYjfrKfz+oXNedgxe5MpxHZoC9NcJ?=
 =?iso-8859-1?Q?0FDuUZQG5nuJ/UndE0RZVCPLTS/4tDNql0OUqIKzVyioCXAtMisKFQ4B1C?=
 =?iso-8859-1?Q?PdembzbOexLE0mGMTN2kU845Tn7xQJfJPI6CQoqOsWnSs2WfAewVmEHZDg?=
 =?iso-8859-1?Q?376Wxuz2WMaEXvjwVbfgeTNDRcJ6Vx0TwCg3hVyR4jTPe8w3hDLXM82F3N?=
 =?iso-8859-1?Q?dlgQQuNLBs52Dnc+a02GFktCq8j5UDlD4oiL5MRMmAhTycDsJWizZv7Kd0?=
 =?iso-8859-1?Q?wNm7WiZZmnCEu0sNqbeHu9YlN3zg6aCGrDVZCntyY2dGcQFX/5uXXT657Z?=
 =?iso-8859-1?Q?Ua4xA4bzUAUqj5eeP+dkgaf2o8IDLnw2GXXsJJ4O8HlV/HTgkUtfBTdQs2?=
 =?iso-8859-1?Q?FYwaoe68gqEeccdNTsOFGi1TBXMgV7Em7V6zgl+/Rol/fppee0ikalF+x5?=
 =?iso-8859-1?Q?osNg+zo4x4eNCPn9fjzWFpkaaa49te7tYCWagLhxLcSnL4K7baMgZcv75X?=
 =?iso-8859-1?Q?IA/O4wrXdDrjmVyD8k8q+Lh9SlLPtwUac1hjqflVWSFu60gICbF97YmhUv?=
 =?iso-8859-1?Q?kU9RWzlBfyu395qNeA2vc+7f4oGmAXedpn7HbHAi6pte8fatNw0Aa8oVFn?=
 =?iso-8859-1?Q?Ry2IwPLIMLgit4XJ2sZPfGRgKqifcWPZ5S1Op0h63KI1M+VFlehTQc4oqL?=
 =?iso-8859-1?Q?9SioOthAuwMRhxzZZSA3z5PIiWztRPCvYdbOtNQfyKUaZcB0P9CWs3HnkI?=
 =?iso-8859-1?Q?4xyXhZJ51zi5pJ+08M9ZLCxCu9d8LZjPcPOHR0o6JbAaFOO829QyA/8o42?=
 =?iso-8859-1?Q?znL5sGEUz9K1wEw3eEhVzNjCeEo14rUzrj/FndVyyDgDb9PsUkGVfWbvIi?=
 =?iso-8859-1?Q?xmTpMkc6vXAcWrAs0kRFMmq4GMpaYqz4y0Mo29UMfeavP/yDPByaEyqGWr?=
 =?iso-8859-1?Q?5U10ibi2wHJQKjRlaTcSz8kaLP0RKN3bsTi59B2uTXQjmC8OzaozvGK2A4?=
 =?iso-8859-1?Q?nn5JmIXOfeLYOBDHP8JeU1koJo0GPE8NKttyknploRr7YNL6q3jxJSWNC7?=
 =?iso-8859-1?Q?QjazxAtRlOVS4549+YCy2gUXVDcrznyuG87FdbxbK7Rr34+CxUReWgdzrH?=
 =?iso-8859-1?Q?xZQhj+LM/2hpR5aKFYSQXbo50jzk3e7bIIeTFKXTlAEhgVbQP/jICbvAvq?=
 =?iso-8859-1?Q?3E7h8rp1SJJzRu6VHGv4JyCJ6EkKk9+LZjfvfeg+qbs88IB3CelmTAfI1A?=
 =?iso-8859-1?Q?MEQw=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d65ea2f-d34f-4d4e-7392-08da39141469
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:23.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRWkYLCVZwhUJ6xqA3Ezfv/VbSIZNh0qDb/HVAyJJ9i9TLpn1ctiRi62DSf2HVqcedyEjPKWl0wAhqoE3MjEJSuc+OiLlMShM6D6zrjmZ7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0688
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RCVD_IN_PSBL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4764]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [42.159.164.98 listed in psbl.surriel.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [42.159.164.98 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.3 DATE_IN_PAST_24_48 Date: is 24 to 48 hours before Received:
        *      date
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Can you do a job with me?
