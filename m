Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1931632E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhBJKGT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 05:06:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12717 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBJKEH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 05:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612951447; x=1644487447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nN6H+jJM2wVkOCz8AZzoS6U+BImifu28hiSAhZd1Rvk=;
  b=r09Wo2mmIWEvhF0PHQRsbhd0n3HWInITZnrgg2Fb0gK/2JVAZqnMPpss
   KUi7b581C25rgqWHQdE5qPXgO8cGSgYwAZojVrxtVcBG9FN1hgiEblHmi
   9KYNzCsnbivE6M5xTriPQZ3UvVmy/Tb5M4JOzz5fYTw8X6jTnsdlq3/OG
   SW00zcgRU5BmfmZiFYzmSuTkEc6yvjFDPrbf7HzF3si6Wgt/kb3m+0jjY
   FDI6HaAtub31cW6U3oP5XYc2VTg+ap3sxrvNJ2sTei1xkIkEilqk/fSr5
   lcbBHjqrtmtYhQIKzsHA+7AIuzqjVGGWDFySeWehHc7m+lbNjNLRqCtUv
   Q==;
IronPort-SDR: 5SSDtez8PpSfvjCPvLGYw31tHSAZ/T0BKqozaGCTGPLOBqG+6cu7bftrs2EMFOJUFIA9DBH1ru
 N1f6PjXVxzy5oFaN3K1QOaUuwZKspEg8mIb++f04lAoNbjCBieK5IxGj4/QAvehfnAByhQdbvb
 r386mExdPUHg954OYRNsktP1lrP1POWpgz1UbsYavrrbhJa4tpWWNZg8nAWHUrbTvUbhApNmPO
 g1VMxuB9YWjBu+JnNfMdtTSYdbBZmkYCSPQE4JgkDi96nLl8xixb7d3UWHBiFM+2YnYXIikq5m
 Clc=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="114532763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 03:02:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 03:02:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 03:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz+ZACGsKY7Syu5zKZj9/u2ALxYuRiry8Af6p3qORhl3tVwlj0RBQIRKEw3ZOq5rG2FHUWHby2IwGDy4EKHrYtmMpSgS3Un3t4NW+JUbFZTaig/nhnvJ0Rn6l0ajyIGbWIPCNjLvwjMeOSIPzgrrHW3TNMM+Hd07SU4imRUZMBU+8IN+sdxYm0qSFIRa4+YTtkt329xC0EWXs/RG2y85r4nms2zFk3DdpW70im/HIfmfhXyoTZEG5GB8JYAjzN4jdDZmB7LGZndHq9xN1r/n7SHSbg6cV58K68Lj50g274lnk88HYUyExFRoIPogdL2/a4nDnIWtQQj9eaRDCV+P2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6H+jJM2wVkOCz8AZzoS6U+BImifu28hiSAhZd1Rvk=;
 b=SdfB3eJ0ZEYGrCPJ3Q45ozNR9OD38ktodhQqN0Nn+P/A5C3Vq089plGuZ6LBy4AxrQCF/xu0QQPlzxloj415bf/LRd4nL5vvivx7qkZOhz5dRCN+b1+f1lGDIU7uyeGqBAmH41NKmMxNkZzy5JdEnA7BNHeCq430Ymbf2DdjD9+5WLrFgJGLKexXYNPLWedb1IYEhIvlLY1IDwCpU0cpxTxB8oxh9H0LMl8EXq28TtI+nfezkkpN1q1BO7KcV8gQsCt3eyJyf2GWGqE89+D9m5/zaVtTjUrWZNxxFRb9tqnHeb0wTE6Y2LC/dxAwVW0Dm3hiHmWYWNBQAilRS+qi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6H+jJM2wVkOCz8AZzoS6U+BImifu28hiSAhZd1Rvk=;
 b=aqh1F60Uy7K5kxbNcx1pgoPbf2b4L/28rfNpHqtfO67VZ5bb1ynLRfbvjSo83gwW9xF91dNVHDfZVbu3IuB98hmES36PS9AkiVNfmHYJBD6iGyDScsZtt7Mq+3XaHhqqcigEr/wE3jr0/88ilkdkhBAj3N2ZP152MmBKh4XNQkY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 10:02:43 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.031; Wed, 10 Feb 2021
 10:02:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>
CC:     <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <lenb@kernel.org>,
        <pavel@ucw.cz>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <geert@linux-m68k.org>, <kernel-team@android.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
Thread-Topic: [PATCH v4 0/8] Make fw_devlink=on more forgiving
Thread-Index: AQHW/4V+vQSyjAznUkuJJWGt4Acu+apRFcEAgAAS84A=
Date:   Wed, 10 Feb 2021 10:02:43 +0000
Message-ID: <3ec7ba3a-bbf6-aa5f-7800-4fc91ab199ec@microchip.com>
References: <20210205222644.2357303-1-saravanak@google.com>
 <47ca46aa-99f3-5203-8aa7-65c6443bd965@microchip.com>
 <CAGETcx862JPn8759tk-69WySBvokxMXJaaOVY7L6V8FLwfpV8g@mail.gmail.com>
In-Reply-To: <CAGETcx862JPn8759tk-69WySBvokxMXJaaOVY7L6V8FLwfpV8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76c7195b-dd19-4bd5-6561-08d8cdab027c
x-ms-traffictypediagnostic: SA2PR11MB4828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB482837B7B7C07E6B9F7F8528F08D9@SA2PR11MB4828.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcs0PxIRQwZIhWb24fh91I3VxpIiE5hGz5FBJBrUBOEPXG9kkm14CP8etNWOBST4adN55ifiQX/chB9YGoO8qJGXdcDgfPTOG2vPWIoS1iNteV2BKBN+RWq7q/8QpCYEg2JonEdZ5roTrcwertJNrGn6dG+EG0eDm0CIF5oE/8B37Mno6Pwhx6WrA0fV1WWOKgks4fIoX1YYiSfWyaeqfIIXV9j2k6DX5wc90hfhxkVH0SOr2ZZRyyJ4+KBTzDdCR7TpzFc+/QT4BFb26UXy5MdNwuHBmCcdi4smSciq9wC02ymmQ7lP6uZCA9YiIDzXAi9WogWvTJ6A8FhY0JK5CiJb2k8VTRf57hfANiqUNd009vEc3RZg2xcjITYoA/aYpNgkVti6xaZxANn5LQBnq7h5CuNXJIK45PviOrEKD5JZzydhCUHXbARMUf7t+qjaeBQxWA1tFEgP5uVUj2ndCElxWPcLxZx1Ibot2OD4TA+SkFoZvQdz9jHRoyFT7MKhZQ9xyfNBKcvFBqyIVMBOqrWJKmWTGOI/2LfFn9EraLqT7ht8fruVjmGAy2HJqr0z2G014kn+r57Ga+buNxz3Z6YlDTqqmMaec3tnGLyYh1Et8Gno2dQz8ietrTqpiIqouNJKOL/vhx9uD7JocULIo4jHQc2w+tEywULL7WEBUUiuCKwz36HJd1BVDmUxM9No
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39850400004)(366004)(396003)(6512007)(8936002)(2616005)(91956017)(966005)(8676002)(2906002)(66556008)(4326008)(6486002)(86362001)(76116006)(66476007)(478600001)(5660300002)(66446008)(64756008)(66946007)(83380400001)(54906003)(36756003)(7416002)(316002)(186003)(31696002)(71200400001)(53546011)(6506007)(26005)(31686004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHBVbEsxZlBneTArOW1CaWFnSTY3SHNJVmZHREZnTS9PZ3k4eXI0bDJxTERz?=
 =?utf-8?B?dEJBT2FzZFhWc1FQbTh2VmFXeEV5Z1FWRUJENkwyZy83a2Vnc0gyMDhKZnB3?=
 =?utf-8?B?RmRtYVRXYm9SV3A5VUE2QmViUXpLYnM2dFRFYXF6NVdNR1FacFVVY3VYZ0g5?=
 =?utf-8?B?cUdnWWpIQ3MvdDBZVHU5QW5BL1VkSSs0Vm5yNm90Wmk1d0s4YXRNNkYxUE9o?=
 =?utf-8?B?dmxzNTJaclI3Q3UycGRTOG4xRElRdkpiVDJqNjJVSHBPcm5rQmM5UTVkNHRF?=
 =?utf-8?B?T2pYd0RaQXpIZXllZXFHWTd0dG5FeGN1Z3pxS1M3cUMwNFEzYWQ2YnBlWnJh?=
 =?utf-8?B?MXRHU1plekdON0c2d3oyNXJQTGdnV2FoYWxBQTRoclZUQVpnWU51MkVxVHA2?=
 =?utf-8?B?L251OG9ZYUFvTTh6MnZ0Uk5RVm10SlEzWmg4azFmSFliblRYYXhLWGVWSDJQ?=
 =?utf-8?B?Y1NMakR2aE90NmFBdVVPWS8rVWhid01yUTFPVnpFMm9mdjFJbVJBeXowT1g4?=
 =?utf-8?B?TDhsUFQyN0JQZTAzS0FLdEtBSTVCUDRDRjhZTENQMDhmQ3I4RzF6dCtNRWVx?=
 =?utf-8?B?by9NM0l2QTd6dWxjTEVTY3d2bTNyQlhRaG4wT3p4T2l6WTF4cDVjYXlWNy9E?=
 =?utf-8?B?MmRCMzYvWWJXekN6aWNzUCtGa1JxTEh1TzN2OVVJNUhnQUpLWWxxcmhHUnFN?=
 =?utf-8?B?WHpIQ2RZVThkUExpNE1FcGhNV0RNUkJ0OHErc3YzUzIwNTVYQUJYT1h0SHl2?=
 =?utf-8?B?T1NZNEtjT1R2SkU5Vzk0WE9aYVovU05tRjZJTDF1Vmo2WG5tL3l5cDRxVUtt?=
 =?utf-8?B?ak5DMVNsSXVBdG04VmxUU3I3NGJKUUprQyt3SDBxWWxVMnBOQXo1d3pEbUVT?=
 =?utf-8?B?K2xxK25GajdYazRMZmlLRHFzQ1NKNVJVa3NjcDBOOVAxNHZQdVJLbDZNSjJV?=
 =?utf-8?B?TGg0aC80dGFHbUFLQk45aVRvbFJ6TEdaRS9VQnhFR09jZ09UeVpmQS9sSHNa?=
 =?utf-8?B?b29pTGhnZHJZYkVhczNnb3FnV08wQ0lBME9KYXJXVlhFdEh2Y0hNQ3hIb0tL?=
 =?utf-8?B?UVF6cEdFOE55dkU5T2N2TFRLWDlmcEpPcHJaSXYvZGRqMDZSNzl1MFVYcmRH?=
 =?utf-8?B?TytXKzNTN1pqQ2ZTWWd6dUVZcWhhVTFESHZFRGhBUnZodTdOWWU0TDZKTEJX?=
 =?utf-8?B?bVp5T21FT21Fd2EyU1d5ZEN1UVhWd3dhV2x1K2dBMFcyNm52ZGpneEoyMWE5?=
 =?utf-8?B?Sk45akp1MU9pT0VoVHc5ZEsvbi83TUdZQmg0QmdhZG1rVUZzVXZQclUzbnhI?=
 =?utf-8?B?WlZaSlVsVm52VlZsZ3FHb1lJeFI4ZmpUVVFDVy9vZkRIdE1YRlZQMzVwZkJH?=
 =?utf-8?B?VmpKUXlwZUhtbTkzbHFISzRvb0xSS2EyTElnV3dhZkUwMHJmRHpwR3NxdFVr?=
 =?utf-8?B?b2U2MFdoN3g2MnhnZ1lKTFJlcUg0TEpzOU5MUmpWVDNCRDdIeVEzSUJ2Y1di?=
 =?utf-8?B?MlhZeDBPcXRialF6NUtBRlpuY05Qa0dtNHdSZUFjOGZkdm9zTmhucTFJczJR?=
 =?utf-8?B?QXNWYXgwOEdodm44VVFkT09QZHR5WitZSnpiY1E3V3FtcDVhbHA2cGM0N0ZF?=
 =?utf-8?B?YXpxT0dXbmU1T1JvR2R0Z2RJVVdhNlN4RG85ZEZFZ3dwRDBZTWdSUUp2ZGNi?=
 =?utf-8?B?SUNIN3pGSW1LUmhhWHZ3T1dRV3lDbUVmQUFmdGpZdWVqVHM3RWVhSVVyN2h0?=
 =?utf-8?Q?0afN+R0C5zZY+Z7dqg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E27E5695B00A947B94B1BF6CDC6D9CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c7195b-dd19-4bd5-6561-08d8cdab027c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 10:02:43.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0DbxkmL5HZ6xdb2Y9eJWOHr2rdX1/DorOP18rMN4MyFqWFmKZTmRincF/554oozTYOLAQqJBiKqNmmxpWF/TXGVM/PWsuis8IjhxXWxhxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gMi8xMC8yMSAxMDo1NCBBTSwgU2FyYXZhbmEgS2FubmFuIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgRmViIDEwLCAyMDIxIGF0IDEy
OjE5IEFNIDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4NCj4+IEhpLCBT
YXJhdmFuYSwNCj4+DQo+PiBPbiAyLzYvMjEgMTI6MjYgQU0sIFNhcmF2YW5hIEthbm5hbiB3cm90
ZToNCj4+PiBUaGVyZSBhcmUgYSBsb3Qgb2YgZGV2aWNlcy9kcml2ZXJzIHdoZXJlIHRoZXkgbmV2
ZXIgaGF2ZSBhIHN0cnVjdCBkZXZpY2UNCj4+PiBjcmVhdGVkIGZvciB0aGVtIG9yIHRoZSBkcml2
ZXIgaW5pdGlhbGl6ZXMgdGhlIGhhcmR3YXJlIHdpdGhvdXQgZXZlcg0KPj4+IGJpbmRpbmcgdG8g
dGhlIHN0cnVjdCBkZXZpY2UuDQo+Pj4NCj4+PiBUaGlzIHNlcmllcyBpcyBpbnRlbmRlZCB0byBh
dm9pZCBhbnkgYm9vdCByZWdyZXNzaW9ucyBkdWUgdG8gc3VjaA0KPj4+IGRldmljZXMvZHJpdmVy
cyB3aGVuIGZ3X2Rldmxpbms9b24gYW5kIGFsc28gYWRkcmVzcyB0aGUgaGFuZGxpbmcgb2YNCj4+
PiBvcHRpb25hbCBzdXBwbGllcnMuDQo+Pj4NCj4+PiBQYXRjaCAxIGFuZCAyIGFkZHJlc3NlcyB0
aGUgaXNzdWUgb2YgZmlybXdhcmUgbm9kZXMgdGhhdCBsb29rIGxpa2UNCj4+PiB0aGV5J2xsIGhh
dmUgc3RydWN0IGRldmljZXMgY3JlYXRlZCBmb3IgdGhlbSwgYnV0IHdpbGwgbmV2ZXIgYWN0dWFs
bHkNCj4+PiBoYXZlIHN0cnVjdCBkZXZpY2VzIGFkZGVkIGZvciB0aGVtLiBGb3IgZXhhbXBsZSwg
RFQgbm9kZXMgd2l0aCBhDQo+Pj4gY29tcGF0aWJsZSBwcm9wZXJ0eSB0aGF0IGRvbid0IGhhdmUg
ZGV2aWNlcyBhZGRlZCBmb3IgdGhlbS4NCj4+Pg0KPj4+IFBhdGNoIDMgYW5kIDQgYWxsb3cgZm9y
IGhhbmRsaW5nIG9wdGlvbmFsIERUIGJpbmRpbmdzLg0KPj4+DQo+Pj4gUGF0Y2ggNSBzZXRzIHVw
IGEgZ2VuZXJpYyBBUEkgdG8gaGFuZGxlIGRyaXZlcnMgdGhhdCBuZXZlciBiaW5kIHdpdGgNCj4+
PiB0aGVpciBkZXZpY2VzLg0KPj4+DQo+Pj4gUGF0Y2ggNiB0aHJvdWdoIDggdXBkYXRlIGRpZmZl
cmVudCBmcmFtZXdvcmtzIHRvIHVzZSB0aGUgbmV3IEFQSS4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+
PiBTYXJhdmFuYQ0KPj4+DQo+Pj4gU2FyYXZhbmEgS2FubmFuICg4KToNCj4+PiAgIGRyaXZlciBj
b3JlOiBmd19kZXZsaW5rOiBEZXRlY3Qgc3VwcGxpZXIgZGV2aWNlcyB0aGF0IHdpbGwgbmV2ZXIg
YmUNCj4+PiAgICAgYWRkZWQNCj4+PiAgIG9mOiBwcm9wZXJ0eTogRG9uJ3QgYWRkIGxpbmtzIHRv
IGFic2VudCBzdXBwbGllcnMNCj4+PiAgIGRyaXZlciBjb3JlOiBBZGQgZndfZGV2bGluay5zdHJp
Y3Qga2VybmVsIHBhcmFtDQo+Pj4gICBvZjogcHJvcGVydHk6IEFkZCBmd19kZXZsaW5rIHN1cHBv
cnQgZm9yIG9wdGlvbmFsIHByb3BlcnRpZXMNCj4+PiAgIGRyaXZlciBjb3JlOiBmd19kZXZsaW5r
OiBIYW5kbGUgc3VwcGxpZXJzIHRoYXQgZG9uJ3QgdXNlIGRyaXZlciBjb3JlDQo+Pj4gICBpcnFk
b21haW46IE1hcmsgZndub2RlcyB3aGVuIHRoZWlyIGlycWRvbWFpbiBpcyBhZGRlZC9yZW1vdmVk
DQo+Pj4gICBQTTogZG9tYWluczogTWFyayBmd25vZGVzIHdoZW4gdGhlaXIgcG93ZXJkb21haW4g
aXMgYWRkZWQvcmVtb3ZlZA0KPj4+ICAgY2xrOiBNYXJrIGZ3bm9kZXMgd2hlbiB0aGVpciBjbG9j
ayBwcm92aWRlciBpcyBhZGRlZC9yZW1vdmVkDQo+Pj4NCj4+PiAgLi4uL2FkbWluLWd1aWRlL2tl
cm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgIDUgKysNCj4+PiAgZHJpdmVycy9iYXNlL2Nv
cmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrLQ0K
Pj4+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMgICAgICAgICAgICAgICAgICAgfCAgMiAr
DQo+Pj4gIGRyaXZlcnMvY2xrL2Nsay5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
ICsNCj4+PiAgZHJpdmVycy9vZi9wcm9wZXJ0eS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MTYgKysrLS0NCj4+PiAgaW5jbHVkZS9saW51eC9md25vZGUuaCAgICAgICAgICAgICAgICAgICAg
ICAgIHwgMjAgKysrKysrLQ0KPj4+ICBrZXJuZWwvaXJxL2lycWRvbWFpbi5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMiArDQo+Pj4gIDcgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4NCj4+IEV2ZW4gd2l0aCB0aGlzIHBhdGNoIHNldCBh
cHBsaWVkLCBzYW1hNWQyX3hwbGFpbmVkIGNhbiBub3QgYm9vdC4NCj4+IFBhdGNoIGF0IFsxXSBt
YWtlcyBzYW1hNWQyX3hwbGFpbmVkIGJvb3QgYWdhaW4uIFN0ZXBoZW4gYXBwbGllZCBpdA0KPj4g
dG8gY2xrLW5leHQuDQo+IA0KPiBJJ20gZ2xhZCB5b3Ugd29uJ3QgYWN0dWFsbHkgaGF2ZSBhbnkg
Ym9vdCBpc3N1ZXMgaW4gNS4xMiwgYnV0IHRoZSBmYWN0DQo+IHlvdSBuZWVkIFsxXSB3aXRoIHRo
aXMgc2VyaWVzIGRvZXNuJ3QgbWFrZSBhIGxvdCBvZiBzZW5zZSB0byBtZQ0KPiBiZWNhdXNlOg0K
PiANCj4gMS4gVGhlIEZXTk9ERV9GTEFHX0lOSVRJQUxJWkVEIGZsYWcgd2lsbCBiZSBzZXQgZm9y
IHRoZSBjbG9jayBmd25vZGUNCj4gaW4gcXVlc3Rpb24gd2F5IGJlZm9yZSBhbnkgY29uc3VtZXIg
ZGV2aWNlcyBhcmUgYWRkZWQuDQoNCkxvb2tzIGxpa2UgaW4gbXkgY2FzZSBGV05PREVfRkxBR19J
TklUSUFMSVpFRCBpcyBub3Qgc2V0LCBiZWNhdXNlDQpkcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIu
YyB1c2VzIG9mX2Nsa19hZGRfaHdfcHJvdmlkZXIoKS4NCg0KPiAyLiBBbnkgY29uc3VtZXIgZGV2
aWNlIGFkZGVkIGFmdGVyICgxKSB3aWxsIHN0b3AgdHJ5aW5nIHRvIGxpbmsgdG8gdGhlDQo+IGNs
b2NrIGRldmljZS4NCj4gDQo+IEFyZSB5b3Ugc29tZWhvdyBhZGRpbmcgYSBjb25zdW1lciB0byB0
aGUgY2xvY2sgZndub2RlIGJlZm9yZSAoMSk/DQo+IA0KPiBDYW4geW91IHRyeSB0aGlzIHBhdGNo
IHdpdGhvdXQgeW91ciBjbGsgZml4PyBJIHdhcyB0cnlpbmcgdG8gYXZvaWQNCj4gbG9vcGluZyB0
aHJvdWdoIGEgbGlzdCwgYnV0IGxvb2tzIGxpa2UgeW91ciBjYXNlIG1pZ2h0IHNvbWVob3cgbmVl
ZA0KPiBpdD8NCj4gDQoNCkkgdHJpZWQgaXQsIGRpZG4ndCBzb2x2ZSBteSBib290IHByb2JsZW0u
IFRoZSBmb2xsb3dpbmcgcGF0Y2ggbWFrZXMgdGhlDQpzYW1hNWQyX3hwbGFpbmVkIGJvb3QgYWdh
aW4sIGV2ZW4gd2l0aG91dCB0aGUgcGF0Y2ggZnJvbSBbMV06DQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9jbGsuYyBiL2RyaXZlcnMvY2xrL2Nsay5jDQppbmRleCAyN2ZmOTBlYWNiMWYuLjkz
NzBlNGRmZWNhZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2Nsay5jDQorKysgYi9kcml2ZXJz
L2Nsay9jbGsuYw0KQEAgLTQ1OTQsNiArNDU5NCw4IEBAIGludCBvZl9jbGtfYWRkX2h3X3Byb3Zp
ZGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQogICAgICAgIGlmIChyZXQgPCAwKQ0KICAgICAg
ICAgICAgICAgIG9mX2Nsa19kZWxfcHJvdmlkZXIobnApOw0KIA0KKyAgICAgICBmd25vZGVfZGV2
X2luaXRpYWxpemVkKCZucC0+Zndub2RlLCB0cnVlKTsNCisNCiAgICAgICAgcmV0dXJuIHJldDsN
CiB9DQogRVhQT1JUX1NZTUJPTF9HUEwob2ZfY2xrX2FkZF9od19wcm92aWRlcik7DQoNCkNoZWVy
cywNCnRhDQoNCj4gLVNhcmF2YW5hDQo+IA0KPiArKysgYi9kcml2ZXJzL2Jhc2UvY29yZS5jDQo+
IEBAIC05NDMsNiArOTQzLDMxIEBAIHN0YXRpYyB2b2lkIGRldmljZV9saW5rc19taXNzaW5nX3N1
cHBsaWVyKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gICAgICAgICB9DQo+ICB9DQo+IA0KPiAr
c3RhdGljIGludCBmd19kZXZsaW5rX2NoZWNrX3N1cHBsaWVycyhzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGZ3bm9kZV9saW5rICpsaW5rOw0KPiArICAgICAgIGlu
dCByZXQgPSAwOw0KPiArDQo+ICsgICAgICAgaWYgKCFkZXYtPmZ3bm9kZSB8fGZ3X2Rldmxpbmtf
aXNfcGVybWlzc2l2ZSgpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAg
ICAgICAvKg0KPiArICAgICAgICAqIERldmljZSB3YWl0aW5nIGZvciBzdXBwbGllciB0byBiZWNv
bWUgYXZhaWxhYmxlIGlzIG5vdCBhbGxvd2VkIHRvDQo+ICsgICAgICAgICogcHJvYmUuDQo+ICsg
ICAgICAgICovDQo+ICsgICAgICAgbXV0ZXhfbG9jaygmZndub2RlX2xpbmtfbG9jayk7DQo+ICsg
ICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5rLCAmZGV2LT5md25vZGUtPnN1cHBsaWVycywg
Y19ob29rKSB7DQo+ICsgICAgICAgICAgICAgICBpZiAobGluay0+c3VwcGxpZXItPmZsYWdzICYg
RldOT0RFX0ZMQUdfSU5JVElBTElaRUQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPiArDQo+ICsgICAgICAgICAgICAgICByZXQgPSAtRVBST0JFX0RFRkVSOw0KPiArICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgfQ0KPiArICAgICAgIG11dGV4X3VubG9jaygm
Zndub2RlX2xpbmtfbG9jayk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
DQo+ICAvKioNCj4gICAqIGRldmljZV9saW5rc19jaGVja19zdXBwbGllcnMgLSBDaGVjayBwcmVz
ZW5jZSBvZiBzdXBwbGllciBkcml2ZXJzLg0KPiAgICogQGRldjogQ29uc3VtZXIgZGV2aWNlLg0K
PiBAQCAtOTY0LDIxICs5ODksMTMgQEAgaW50IGRldmljZV9saW5rc19jaGVja19zdXBwbGllcnMo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2VfbGluayAqbGluazsN
Cj4gICAgICAgICBpbnQgcmV0ID0gMDsNCj4gDQo+IC0gICAgICAgLyoNCj4gLSAgICAgICAgKiBE
ZXZpY2Ugd2FpdGluZyBmb3Igc3VwcGxpZXIgdG8gYmVjb21lIGF2YWlsYWJsZSBpcyBub3QgYWxs
b3dlZCB0bw0KPiAtICAgICAgICAqIHByb2JlLg0KPiAtICAgICAgICAqLw0KPiAtICAgICAgIG11
dGV4X2xvY2soJmZ3bm9kZV9saW5rX2xvY2spOw0KPiAtICAgICAgIGlmIChkZXYtPmZ3bm9kZSAm
JiAhbGlzdF9lbXB0eSgmZGV2LT5md25vZGUtPnN1cHBsaWVycykgJiYNCj4gLSAgICAgICAgICAg
IWZ3X2RldmxpbmtfaXNfcGVybWlzc2l2ZSgpKSB7DQo+ICsgICAgICAgaWYgKGZ3X2Rldmxpbmtf
Y2hlY2tfc3VwcGxpZXJzKGRldikpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAi
cHJvYmUgZGVmZXJyYWwgLSB3YWl0IGZvciBzdXBwbGllciAlcGZ3UFxuIiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgbGlzdF9maXJzdF9lbnRyeSgmZGV2LT5md25vZGUtPnN1cHBsaWVycywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGZ3bm9kZV9saW5rLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBjX2hvb2spLT5zdXBwbGllcik7DQo+IC0gICAgICAgICAgICAgICBt
dXRleF91bmxvY2soJmZ3bm9kZV9saW5rX2xvY2spOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FUFJPQkVfREVGRVI7DQo+ICAgICAgICAgfQ0KPiAtICAgICAgIG11dGV4X3VubG9jaygmZndu
b2RlX2xpbmtfbG9jayk7DQo+IA0KPiAgICAgICAgIGRldmljZV9saW5rc193cml0ZV9sb2NrKCk7
DQo+IA0KPiANCj4gDQo+Pg0KPj4gQ2hlZXJzLA0KPj4gdGENCj4+DQo+PiBbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDIwMzE1NDMzMi40NzA1ODctMS10dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20vDQoNCg==
