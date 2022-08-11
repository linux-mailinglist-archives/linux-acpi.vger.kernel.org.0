Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3530358F8E1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Aug 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiHKIPC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Aug 2022 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiHKIPB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Aug 2022 04:15:01 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2046.outbound.protection.outlook.com [40.107.11.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220AA901AC
        for <linux-acpi@vger.kernel.org>; Thu, 11 Aug 2022 01:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkTNpaMPaTIOFyAlz2pmxUgqpsZAavoCAaWQZZs7WgbDNP/fRazRvTPm82m/cBvPay4hmHyvikMWhdYiHwURvXu6tdnT2X5F1g2ELSe1uL2uxbWZGqaH3WoQqkeqUNsdPbOVQwcxwR/g5+oTjwVhCUS1PX4EcZcDgqYccf7YS3ypvuqCyNNkkHgKEMOd24t9Jp4rsaso4tVzLPVHjca7mJv3ZlA7EegDkyGGo7iRGD9YIX4xVPkTlMqZ3TDbwskQEHzOLZhsL/xGJA3tIt8pYxlPKo/lYFhQAdLbQUz55q35UoEU9LGA0Qq5ppe6w4smIm4lOcEdNL5fw+y4yRJjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGOUdhnyQCLk3wkkO57p1vlYHhnrZEk1L6NBff9bHBU=;
 b=DmFz2Ngw0dM+wzGMuRrIpldK5k11W0Moxe/0K2y+BAY7EeBhGQnCizZxkQAtUqbc8m1EV/ogwYjZFIKSGBvmRPCRpbP9ZavZRr80slkfnSFuJNRkw000UvG1pRKN2PwK1iYBWOyzm2chbgpYD0Rb2GQ0YYka6MUimCmO9D8QZBVi4bLv+vsXYlFWwMRLKK6cUCsYhza6z//4CDttHYpgfwAUhYY/Xql0P8fKnQG/S/tKBq6kI0q1L+/8UGsiNaLKbuQM6+3QhFaGmculgsFmvxxMWq0LrCWy26POSf7rZRFjpXeiWThn0hCLSSpYf2r8OxjDwxD2EbnhjTXHUhkOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phabrix.com; dmarc=pass action=none header.from=phabrix.com;
 dkim=pass header.d=phabrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phabrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGOUdhnyQCLk3wkkO57p1vlYHhnrZEk1L6NBff9bHBU=;
 b=RZt/lt0ntEVZCGsdcq6ps6pWDT222CrvqB8l4MWf2t5ZSjuz3ofhRps0Ef70XTtQoVb35GD7+F7wWkfuh7d5SERf8myxnqGcto5bN7WXLhGQVPXfZlxRwgfrTKonHI1P1olUct+FV5xfkHtVcB8hchdFBD+0ZT5p+M8Lmkem7uI=
Received: from CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:179::5)
 by LO2P265MB2576.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 08:14:57 +0000
Received: from CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a58f:5b1b:89bd:4f62]) by CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a58f:5b1b:89bd:4f62%4]) with mapi id 15.20.5504.023; Thu, 11 Aug 2022
 08:14:56 +0000
From:   Chris Pringle <Chris.Pringle@phabrix.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: MFD ASL for KEMPLD
Thread-Topic: MFD ASL for KEMPLD
Thread-Index: AdiozwPse+4XCDExTTOdRTDKAJ3e/wEi2z6Q
Date:   Thu, 11 Aug 2022 08:14:56 +0000
Message-ID: <CWXP265MB4508732ACBA8FF6CE55A9110EB649@CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB45086577824516B96F8DEB4CEB9E9@CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB45086577824516B96F8DEB4CEB9E9@CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phabrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb9f1cd-347f-49a2-fb64-08da7b7193db
x-ms-traffictypediagnostic: LO2P265MB2576:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE7O6bBE7ip/rbFuiI/cRDbXxUt3OAlLSf5ZXYzw+uJSKUbxLgcI3WlIKpfcmbFcAB49ohxDI/EuM3WgOwiEsvOlipSyG5EYYC6Jj3OFjuvOMq/7KRXGelGQSITmvaTlQL33YHVb8+KRePFiYJ3/fv328pp8AfAIHMAdhLoUtRTLeyDLM6JrmKOiap/cbQSdAKhfaJWzw/GbXRpsGvOtTjykD0ENkq0QcloZDbPSjkyljQeK3DkBnyhXY7weBzMARU93QWdbhVp21oRfdm8erfLaQq/q+HjUYPru6wXa6jK2mHkAj1lZLJePhLo4nsreIL1YqvhbuXT9YnvSTWZsh7K6W0O/ncOwHvvwJacYh3vwoVrbyurIwv7xdJACUULMUZu/I3Z0wh7lgfKuMe3lAKbtHc+nAMz/i4wSyRHWGzlakAt9Wc1CGDjxF60hvjC1zwy9YNxTSmKxmf4GPrAr01FivfC3a7nR0w7Bz3HQTJL2LFa8VWlQUf/twtUvPUZBeWlhekJU86ReUIB+uvRffMbYWsHwC0iiYXAYgW7X18iCNbJkfD+PHa72h1CrMFjrlt/zd/Uzcc450+nGaIbYYHHoqWVL5AsqocW34N5wW5+D3kRqJMVkYbv6EnHUCXLAYrvITNS1KqDV2J25gYkqjOsFjkPgnfkcIQdc115v9z54CwJK6HvmMu3FzNISdjk1pUmJC/trjiI9U6EdOPfFtxqIkJPY+V2livcgOZ7+zhctAv7UQcuHgfOXPkJFIOFBYL0+YGJk6C1VTTAPiJmKQWFSNj2CsGLsA3v0IBtLclftHo/V0uMAbdVPETAMXQVt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(39840400004)(366004)(316002)(122000001)(71200400001)(33656002)(41300700001)(38070700005)(66946007)(66556008)(66476007)(2906002)(66446008)(64756008)(8676002)(53546011)(6506007)(26005)(7696005)(4744005)(38100700002)(76116006)(9686003)(5660300002)(186003)(478600001)(86362001)(83380400001)(52536014)(8936002)(3480700007)(55016003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2avjNxO2cQ3c2PJOS9wA43EoVrv3TcZovFDeMQKJkGVugOd/euX5JP8Pnzw3?=
 =?us-ascii?Q?SLmUhYZLBxYNP8K7O262n4Wwrqxn1GaZyHkDPB3wr9dUW8Ui/uJ+teE3fcQ8?=
 =?us-ascii?Q?OwDFvlYEBoVYlfpOzRNupz7NUGVvaZ++zHTtjYTGGk7/UBKloPXFEt3zfyg9?=
 =?us-ascii?Q?6nF/9Up6Q6ZnQDNqZc8mxzVwSOVpBPqmGwyBKAFYVCjVwr9j0bJeA03CajiG?=
 =?us-ascii?Q?BYYcreoLHUrD8+yk8VNmc/duNk7p04KCMImyV3yBVEzQl0deecksMTOReM+G?=
 =?us-ascii?Q?v3/qrroSFFPq9oG1xwVyKUmMSgu7ipyTMw400Ml/e+p1EHFj2/TOMnDStt0M?=
 =?us-ascii?Q?Ln6mT+6Gxhh96I/eDmVYuvnBAmIRoxM9ShCCvB55g8QuHyiborjChwa2ppPT?=
 =?us-ascii?Q?g1N19TNAmXG1Ev0OeZ5pijLaJrh1HwsMubwU9/rZQSKMJ75C4wXzk36kuLQl?=
 =?us-ascii?Q?cYyh4Xlf9N5YOcHuyOVynKqLvcH6Ac4A4e7PbBWHVtHxneWWVThHRmEi8Tvl?=
 =?us-ascii?Q?1F9C1yQSyGwmoggkHI0+7L25gAees6mg17TGhP4tAkhjflQrCR0HyXhYb0Bh?=
 =?us-ascii?Q?TttOLIkMbu1MpMA5LSo/4v8GXdVlZ5hLriI9PClSQjFetvONPq6jpb0Y39ib?=
 =?us-ascii?Q?AX8y+yYncmM7KNCH0mU/I4NEfqhULxi4A7cPAVTsNjkwV+cqf8w/+OJS8Qja?=
 =?us-ascii?Q?m0oLrZsakXHSVHO8ROEdY3Um7ph55hyWVzcgtH4x5F7JMtx9wItmxri6dpoP?=
 =?us-ascii?Q?BPmC4/AvGL844gFQdcRRwWc1VKo9mtsR+1lXatRvzfI3xmADD0s+vO8OmRH8?=
 =?us-ascii?Q?QVn6TaX5cQ15uhaRpvNsxKu8lb9vctahPBT+3IP0ZFtOPC3vNFQoMA1xuoRi?=
 =?us-ascii?Q?Wo8hlL/Pm7Nj5FYpvz3e04HfBTwOCvRY7jqaD2GpoLYudsHwdDdv6UceX7fk?=
 =?us-ascii?Q?pelK5akih2TdN+wnm708h8uQtZakfE3Kg5nCRjb/Vaj1PCZllYagyO30GZkN?=
 =?us-ascii?Q?5bJrVs+O39NbsrKRodA8zjw48U/0U8AndXL2webNfC4GQUpYAzEaV8le3a5+?=
 =?us-ascii?Q?oOpKLeKxlLzrPOpweXrbCkDBA+uxjhxGAiExwpoqAP1WsYP98vzfyPTDdg3T?=
 =?us-ascii?Q?IMOlXqj9MYZyN3YT3xdtWgWElEYEdmuNG0TwVZRZsqT3NS+92rSWhbO1Bq5T?=
 =?us-ascii?Q?KGoby5RZ3IeoS31yu4fap3rDXyfzKmZjYpdd+DfRCNrWhwE6xHPa1HK2dZpJ?=
 =?us-ascii?Q?kJB3kddAlQZLn2mCVtKHNcJnrbrmgYcYuiRszrtwZ5as1FNsi3725ye1K1ow?=
 =?us-ascii?Q?Aj1lMGE+zIWX2QvsXG1cUxoGfIFSbweUK07zna41nl2CmSGn6yh15nmJmHN6?=
 =?us-ascii?Q?2JDFGdeASQClIKkQpRmS9261WEry8fC8nSUMEEON3XFLbZyNvdRfTan040Bv?=
 =?us-ascii?Q?M6lfkGaYoeq7FW6yMQCtIeguUQGtoBz447WmrcFeR8kJtpBvOxY2REK3+GPU?=
 =?us-ascii?Q?l2SOCygFxJ4+z64P75yk5apF00kPEmhHOtvv54h9XCIl7XUsmiTHsXzwmjth?=
 =?us-ascii?Q?/CRm7iOTMLeXZDAOcOkfIKo8qxzcMLesERNTATiq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: phabrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB4508.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb9f1cd-347f-49a2-fb64-08da7b7193db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 08:14:56.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20a0d659-dc6e-4307-9c1e-97f93b0e3d90
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfRWh5E6SChzC9y4UqSRM3Qp/gBuvyfTVXJSKig/4tt9MLXW5JweL+2gA83iE1f9hLylLv6lHTghps3et52Qadhn4fggRm4o/V+zApH2LqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2576
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 05 August 2022 14:42, Chris Pringle wrote:
> I've been trying to use an ASL to help me add a bunch of I2C devices to m=
y
> platform; to start with, I'd like to just add an I2C MUX, but have so far=
 been
> unable to get the kernel to add my I2C device. I suspect this might have
> something to do with the I2C adapter being under a MFD driver, but am
> hoping I might be able to get a few pointers from here to help me get thi=
s
> working.

Follow up on my own message - this is happening because the KEMPLD I2C adap=
ter does not have an ACPI Companion. I'll post a patch to linux-i2c and the=
 relevant parties.

Regards,
Chris
