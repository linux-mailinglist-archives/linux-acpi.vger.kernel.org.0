Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1BB446032
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhKEHmF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 03:42:05 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:25087 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhKEHmE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 03:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636097966; x=1667633966;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qyL8myc7hK6JL50dpDikpN2K5cVJh5MDxC06+QR98Vg=;
  b=Qvs+4dGEWOmmIQY6it9mNUa2MgsAKrCXAM1XVtX8P764lMWmIjEe8XwP
   TcNZmGiIQkO1AKsW4SXA9dj9zFtdHPm1I0qt0ByQTTgP13YKQK8fkOXSa
   bYw0m1Js0lhUJ3CY0IG/auVmi7etaEkhwMRsDvVS8RAvtFD+eDPYBEUd+
   uXQSKYBWLIPJRU+WLCqU/M7uoQm+3zG4ouQxDk9yNk4AHHQbv4SP8hAOT
   yMljoUdOXXoYgKvLABMMwge3jEhOWAibnPPWq/8aEWxh3zt/9niWjuKdU
   qZVJyngP9FPg4N8G2ndUJCd+lWOMTvo5zV0hJqigN5gpMhOTpCmm1rO6n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="42835499"
X-IronPort-AV: E=Sophos;i="5.87,210,1631545200"; 
   d="scan'208";a="42835499"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:39:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUWMF/maxd01kjbRl54qfp5mZgNF+1urOsV+8w0kgfToZNzmZbUf/c+1ZJ+xiBCjnJTw3G390a5bzIyDBvwoEtR3weZFHczNMWqBILZrH/g6D/2FIRAt+E7S0bT5x/LeS1WCBWcfVI5UgHfZrONZc8iWmcRga3XZb+9eW4668QN1L8Y76WlB/v47cbV75Y3WkanxkDMpMSPkwygaTxCI/NBzyXU39nXc080POn2UtocxqoIHxpVGAR/46cEev0IKO7iDnXTiabubc7Na9dNpej0z7i1UHsYiEqpHkm4w0rdfnqwtX8Qv/02aXZefmPeRiGWH2i0e2akBhk315u20zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6b6c7iB8tzOM/BWUEPuSiGpRjHX1VCDZNJKIaMxUGM=;
 b=himMQTGb7slKCb30hTA3eP8/yVhvz6G7dZocnnH37rW8rRXwAzr4wf4pZ9cSWylF77uhfN6+It/g9fwqNXV2bEH2V4JHVXiDz/IYoxZUFxVMDVG1xt2kPuELucl1lf2vRPyJLNEVptoyAf8yeZ300qx7kegdTWEeF/rXMRjipUdEtLux1VTyZtSUfdeYN4ebqYhkjXGM4nXMpF/Z/Sffi+i7B+0J/5UOucZ6ijSsEyaKFujcS/JYvFGxeVR+2LSL+4oXW/TEJS/+SoXcZaurLwzwdvGdfZqNAfsGQGReaAyYOWRPo9Vi28fAyF6CMEiiyzNGK3fnKULYabwaXV0IZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6b6c7iB8tzOM/BWUEPuSiGpRjHX1VCDZNJKIaMxUGM=;
 b=H7SL6Y/nOLagrASZOCVYj7q5I/NLNMrJOMnOs20/jVvHSfjBVSlH3xhk8HPYd00lFK8SwcEFQ2zZL5kacMU2pLftDOmvXrdKvnBlFfZMG4zZAEvnsROURdyIE9yZvKkI0mej1lZs88+JqVDBCkxdtjBohlpJMIz/QaH1z7TEGDg=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TY2PR01MB3914.jpnprd01.prod.outlook.com (2603:1096:404:d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 07:38:59 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef%3]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:38:59 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "'rafael@kernel.org'" <rafael@kernel.org>,
        "'lenb@kernel.org'" <lenb@kernel.org>,
        "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'guohanjun@huawei.com'" <guohanjun@huawei.com>,
        "'lorenzo.pieralisi@arm.com'" <lorenzo.pieralisi@arm.com>,
        "'sudeep.holla@arm.com'" <sudeep.holla@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: [RFC]Development of the AEST(Arm Error Source Table) driver
Thread-Topic: [RFC]Development of the AEST(Arm Error Source Table) driver
Thread-Index: AdfSGDHsXUkIll3WQs+FTgdhiSd6cA==
Date:   Fri, 5 Nov 2021 07:38:59 +0000
Message-ID: <TYCPR01MB6160251FF2C341948BD0FA37E98E9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9M2IxNjJhNTUtZGI1ZC00ZmMwLTk1ODUtNDE1?=
 =?iso-2022-jp?B?OGExZmFmYzNhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMDVUMDc6MzU6NDhaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e73d476-e060-47fe-9ed3-08d9a02f54ca
x-ms-traffictypediagnostic: TY2PR01MB3914:
x-microsoft-antispam-prvs: <TY2PR01MB3914E73F65B5561D2F990424E98E9@TY2PR01MB3914.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u62+MabgbThvcgu1my8W6sF18LSyGfxnhohBPvYgKQsmm9vDLrrultcYXsH6F5cortTfNizfL+mWhRkiv2jgi1cElcowAaQPSxebfExQ/5xFROpMkXxLHvCNvKbZVHch3Y6Xd+SfNvFRwkB7mTiNxIT1f0gjNnyatTX9Zbk5hXi94/FNxzqAZUb9fzxXy5VPlxOVWQ1rd4BGBlKh6vRnM3dnwEaoJydwmGIkJ6AuVuHSReyyyDFp0kTK6mu1U0sxjzYdpokpzB4S0r7h3fnWOzcWuJ2FzRnVjwt3jCT21q65sJz+u42xPQt+wUYdjQAXMtK5T4e1b5mPZayzkZjGyXY1lcmG4eEqTQi7KZisv0ff/t9HnSJcI0LO1zLK1Lt25ZPrRWNux06odDVJCdZ0zhyo1GI8MxGDVNrG92xZcSasfRSMs+NPnfA5ZS6u7V+WBKo6hJOpJSsON6Gu+uFybfIDKFel+/oD0n7VcS5O40yIE6io1iA3WSXPtn8OwiasrRgAjcHKI+RVw6S/IKVRFi22h3tQzJf9r+Slm6BosEdDdv9qaf6RMHV/Yocum0WHchaxl8Byv/MKRq6kxKArscUG9bjUF/1VmWXIhB9rcrnkKB9D81zTs3Ax/GLG3bxYcJ3xmHeFdf29zgP6Ik82X63k/mGosPbGOa8R3t5IQCxxNB2rV0fg+iMTy/sMcp2iMgoStBKizrwcnevpjaRedR52/PggDpwjJnjbv530GXkJkgB/djBJYBTvP9DEqeH6lgP6sMn6U4/56yIoVLusvbfxOe6yw40LDKTvNxRLaX0tnRyOMobw4uUj6LgJitQX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(76116006)(66946007)(110136005)(2906002)(186003)(52536014)(508600001)(64756008)(66476007)(66446008)(66556008)(86362001)(82960400001)(316002)(8936002)(85182001)(8676002)(33656002)(55016002)(9686003)(6506007)(5660300002)(83380400001)(7696005)(122000001)(26005)(38100700002)(71200400001)(38070700005)(4326008)(107886003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QXFnRlZLVmhtaXB2VHZGNzEvUi90WlIveU1xdDJlbVFhNExCRU9TQTE2?=
 =?iso-2022-jp?B?dW5ZN0ptOE1TWmFxTS9BOVNybWN1LzlHMW0zM2VmbWcxOFFvT0E2b0tu?=
 =?iso-2022-jp?B?ZnpzTG53Y2o5VUdXZDVZUXZibGpQVlJ1UGhzRFBqRFozSXpMOGFESjRw?=
 =?iso-2022-jp?B?TjVyVVg5Wm5rQ0NFK044REtrbGV6aXhiTUFtdEx5aHVrSW83cnVrM2Q2?=
 =?iso-2022-jp?B?SFRzaUJmN0Z6dHI2WHF5V29VWnQzejY1Rm9vUFdCQzkvb0NGVHZabU94?=
 =?iso-2022-jp?B?VW9HeVNqVWFVbndVWVdRd2t6aGFEeTloVWY0YmozYjhIdTFqT2t6RVda?=
 =?iso-2022-jp?B?RnNmbmpGZURyNlVQd2JFcjl3UzZ4WjlEbUVHVk9sRFYzTHdGVmtVU0dF?=
 =?iso-2022-jp?B?OVZzZFJSbXkrNUtPMHhRdGtlQ1BMRGdpbTBJMTJ4K1o3NHJ6RTVuYi81?=
 =?iso-2022-jp?B?NUQyaVI1N29xdW5IU3c4eFVPL0FhTUFQd1IrdXZCL1JxQ2Z5dUkvMVB3?=
 =?iso-2022-jp?B?MFpzcFhMVkduY3R6Y0JOdEF4K1I5ZTFFcng5Z0UrQzFsR2VqakhCS24x?=
 =?iso-2022-jp?B?WHJQV3FlUTFROGtnclVLRmFJUVk0c291WFFZalpsaHNtMlJZQ0t5TXFY?=
 =?iso-2022-jp?B?WGQxQkE0SUtUbFlwMzdvc1VvbHB5S216WUVEWmNoaUc4SWwrVHZRTVBR?=
 =?iso-2022-jp?B?VG0yVk5wVWFGN09mTGlheVdLaEZVVlVrcmVEZmRwZlpxV1FhRlgrOXdp?=
 =?iso-2022-jp?B?UXJWWERGSWw0aGFnemNOV3M2aDFIcE02ZmMvbnBkU3ZEQnRqN3hsWk1i?=
 =?iso-2022-jp?B?UWNEMjd6TFg4NUZTaWxKWnVVdkhWQW1ILzVjSGtOWkhId0EzRGMzSG5J?=
 =?iso-2022-jp?B?eWJDZnhjMXNNa2pnVHFmZ1dZTFU4VFdZd21mVFh1Y0I0dkluVkVma1Bs?=
 =?iso-2022-jp?B?OFd4a3BBc2hoQ3RoQzNEVjY0SW1WNWFxTXcxS0NhbXZWWUxuOTNCZys1?=
 =?iso-2022-jp?B?cStvNDZGa1VOOVBvRWpTRDNpVmxDODlJQlVRdExWdmpvYVlyQ21WSU1E?=
 =?iso-2022-jp?B?ZUJkdXBkbDc5bWp1Z1J0OGJ0LzdFYmNiN1QxdVJJcTRoZGIwbm85bStl?=
 =?iso-2022-jp?B?WC9DT1E5ZXFqeURGVHdLRlB1VmlsRTIzT1RUQWRtNVUwTEpqeUNtZE44?=
 =?iso-2022-jp?B?emduOGpPN0VYYnB0L0xSMGRzWGtyUXVWYkp4RGVMS3lKa0dxZUVLQkVV?=
 =?iso-2022-jp?B?OVg5Z2dYR3dvMWRkZmd5UkRMRUxtRVJORUdRZUZGNi9ZWXV6MXNFQUhR?=
 =?iso-2022-jp?B?cmFhVDY5cW9oMzBuVEJXaGZZMkp4cDBxZE8rNVZLR3N3VWhpOHVHK1hs?=
 =?iso-2022-jp?B?enRyeDRRb3owb0hHL0ZFaEF1b3pHYUdEZWpTTXBkTUFrYXV6OGM0Y2hY?=
 =?iso-2022-jp?B?N0QrbDZjRHdLSGh5Q2dELzhQK29wWEIrN2ZJY1NyN3lPcUJOOGFVN21J?=
 =?iso-2022-jp?B?Q25FSE5vR21EWGpWdHBaT0JSU2ZzaXk5cWh6NC9zcStFSWp1TnhUVUJ0?=
 =?iso-2022-jp?B?eHdSdlVEWWF4QVdKTkNuczU0WG1NcTkxTWVOZkd3NTFCL1lpWVNiOStS?=
 =?iso-2022-jp?B?UHJ5QTdLaXVNZkpERXE4dndBOVc2RDRWcUNPYnhWYmc0UldhZm5Oamtz?=
 =?iso-2022-jp?B?RzZSUWR5cytGNWwvK0xST0ljY25wRkg1SmRiN1Y3SEwxcmlkcHp4MCtn?=
 =?iso-2022-jp?B?UENYVkduam9UYUk1RklVNURTVGVZRHduZk5FQWNCcmRjUjhSY0FuTWVS?=
 =?iso-2022-jp?B?a0pyWW1Xb3hXSkl4NVlNRG16S1ppMHVkOGJSQ25JSUZ2cDhEZ2ROSmpE?=
 =?iso-2022-jp?B?MEE5eUErM1VVZ3RJZExTamxSQ3QxeHpkMkFmSGNzdG9RZTJJS01EQUhV?=
 =?iso-2022-jp?B?RW1aNUU2MVV5dGYwWkRaa2FPaFJiMGZCTXlEQVNRRGNFSU8rZGNjYkp3?=
 =?iso-2022-jp?B?dGljb3hwZUI0QXFMakZYK1A0TDZNNkJjYWIvZWsyeVNiVXd0UGREckE2?=
 =?iso-2022-jp?B?MzVWemRQb1Z6K0t1VkpHZjV2SHp1RkVmb0xxVStKWThCNmxwRTgvQmQw?=
 =?iso-2022-jp?B?MUFEZFc4cGZHUXpvSUhnRTZabGhmaGRMN2tyRU9mdFlLQ2dLRWVaK0pN?=
 =?iso-2022-jp?B?SzFWa3RjMkdJZ0pXK2loazh3QmZpTmdKVndxSUU3Nk9XVnFoVTNUY0I1?=
 =?iso-2022-jp?B?TVBVTXRtd2JFcVVlT3VrUVRsQzJnU3RrNmVsWXU1aUJYSk9YWmI2OC9y?=
 =?iso-2022-jp?B?YUxyMjlIaUp1NDVWZW51TldDUDZzeElpYWpUZkxpdDh2YVllQ2N5RFF3?=
 =?iso-2022-jp?B?YUJPM2hRNUdjd0hsdzVvY2FPYWZBanJ0a2dhemQrOUxyWmQxRmY2UzRj?=
 =?iso-2022-jp?B?eTZ6V1lnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e73d476-e060-47fe-9ed3-08d9a02f54ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 07:38:59.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3nRAbBZyo1Rks3MHoIDJNm0mLSEGKl+u8ESsXEAx8nNMoztWEGe5bY9Iho2azxKf88eY260KzXmo+pTVxRecxKP0Bte12yCMl02naFNBqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3914
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

# Sorry, email address was wrong, will resend it.

Hello,
to all concerned with ACPI (arm64) processing implementation,

We are considering to develop an AEST driver.

Currently, the following has been posted as an RFC patch [1] for the AEST d=
river.
[1] https://lore.kernel.org/linux-acpi/1562086280-5351-1-git-send-email-bai=
car@os.amperecomputing.com/

We sent an email to the developer of this patch to check the current status=
 of the AEST driver.
Unfortunately, there was no response, so we would like to make the necessar=
y feature updates.

We have two questions.

Question 1: About the update features.
Since [1] is implemented based on the ACPI for the Arm8 RAS Extensions 1.0 =
specification, we are thinking of updating it based on the latest specifica=
tion.=20
Any comments would be appreciated.

=1B$B!!=1B(B(a) ACPI for the Arm8 RAS Extensions v.1.1[2] support
=1B$B!!=1B(B(b) Register addition and its dumping process to comply with AR=
Mv8.4 RAS Extensions
=1B$B!!=1B(B(c) Addition of processing for each missing error type.
  =20
  [2] https://developer.arm.com/documentation/den0085/latest
   =20
Question 2: About the directory to be placed AEST will be ARM specification=
.Is there any problem that the directory to store the main source (aest.c) =
is under drivers/acpi/arm64/?

If you have any comments, please let me know.

Best regards,
