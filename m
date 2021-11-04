Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BBE445CA1
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 00:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhKDXcK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 19:32:10 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:18069 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhKDXcJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2021 19:32:09 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 19:32:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1636068572; x=1667604572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THMvsnGxMma3F6gnkpG1ykg6bhX99sNQTXFdvU8F/AQ=;
  b=Y74CSlpMIaXnx365vR7juC5WkwvFvlhxrLhHc1xk1HpKFulG1ZrghVJG
   EbOlcUZdJWWbFrdau5TraLmQ5Yj+VW5l6ODCZnSWcBU1tmIZvialATftL
   CllEP0lU32EFXFYgOFfMKDmm6usig3MSaKuInlhI952G3iIs50O392cCT
   egLE9xDZ0MicpKZGTSXu7/Ej4g6mrrecwbDeScNy5V0yg7GIYxvWMtBnV
   1b5815CckEPEdArNVFFrWSaE/jHkozbqxmw3NGzgJFwZvTPIEflLquvwz
   Kun0CWdxOOa33mH1AKNlxRr6TS0QpzAmienzMecxe06qwllelDU05k7H+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="42739004"
X-IronPort-AV: E=Sophos;i="5.87,209,1631545200"; 
   d="scan'208";a="42739004"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 08:22:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4NlJM8pNAzfIEN11YcAeNB91wDMlNnFmyO2paW3k+08HQRoMD9y+dyhUu5rPTGUdMrxk3nX3MRhyGb60eS2J9MmdZjb8poWDZCvLsTyy0NqHNbNXQ2HMwGdfjtQSdup4Cy+LpG/B/SQdx8A51KHAdMCRqkfYBVIGdWEzpMZXzxSyZxORravF8Q1ZGXNtRkGBeNuLSeUNxWMmyMi4yE+LcpFxXKk8tdlZ8wWKnupGnIYzkuQWQW5jxWLq11HNg1E73K9bg2eRW2xBOdOIgwwIvyVg281flHfdOxsr72HkMI43hANvI/egp0IEK66nKsu+oNCEzOYiHFB1quBKc2dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THMvsnGxMma3F6gnkpG1ykg6bhX99sNQTXFdvU8F/AQ=;
 b=bSGAcM8Dc0BhYcv8P8bX7HkszKdvsGwGSA2mKbfa8DUCVoKvZKkTadi0OLXpCcicwUa2KVCSnigI2U5nmSkIQqmPivPCONbxxjZu2bFLVnfH6FwbxfiZsBkWXc/WYCdvfAiLfw0wlX3mlQJx1LWuFGVPX0hL1Hp8GygmKwCTk3r60cccoigiPLbee4Vm8fFwC5gEncW0EtpkI6OonYjgt0V/0sAmDOh9TX1Ln7vT2RGxhHmVteqFj+ExxNS+aUXq/nSr57Kwa+L0pug/NYF5Z4kWq+6mqe9VPCYUDijF9bMpHWVACXEkIlu1yNf8aLSyF1U9c+lOm8wUxeoC3QgNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THMvsnGxMma3F6gnkpG1ykg6bhX99sNQTXFdvU8F/AQ=;
 b=Y1R+7BrRVAhVhTyE0eobJ1vF8paUwITwqmdb+lcA1rJ5nDHE2WLc7XUYFSwLDI9IUAxRowHxwCOwfQccsvCRzdCKySXMivSTvp4UROI0n5xQI2vQqTM2jbqk7vRtyYZrhOa6cn4qgd2qCVd5ZtgQWMK6jdYD4QkoP+CIVRDSy/I=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYAPR01MB3358.jpnprd01.prod.outlook.com (2603:1096:404:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 23:22:12 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::ac12:8bf4:9dcc:55ef%3]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 23:22:12 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Thread-Topic: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Thread-Index: AQHXyj6Hgz1OGMPqUUClqTokcEL2AKvyn4RQgACq+wCAAMXj4A==
Date:   Thu, 4 Nov 2021 23:22:12 +0000
Message-ID: <TYCPR01MB61605EF2A23EFFCF4B43E952E98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211026075257.3785036-1-ishii.shuuichir@fujitsu.com>
 <TYCPR01MB6160403C510AE93C1EC2635DE98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <CAJZ5v0j4ZvbkdF2Az_5MLFY=Vt7835LA-U2N2qKbZVk9KDx7QA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j4ZvbkdF2Az_5MLFY=Vt7835LA-U2N2qKbZVk9KDx7QA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Y2Y4MTI5MTgtYjcxMy00YTUzLTg5OTMtYTYxMzlmNDRl?=
 =?utf-8?B?ZDIyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0wNFQyMzoxOTozOFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43d54dd3-0a48-40e8-2776-08d99fe9ee4d
x-ms-traffictypediagnostic: TYAPR01MB3358:
x-microsoft-antispam-prvs: <TYAPR01MB3358932D7F74571ACB4E8691E98D9@TYAPR01MB3358.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTZMrBASj5ySJ55V8evcV9oQW93Oyre0NfNIig28b1otDuGDfGvXnt/t/oR3S4LNj45mXySLtjOCxd6B2GRK2pwG3aekA5I3utA8e49SH1MEoiiEM9IVct4xmZ+14aWHW7N6dvTRWXTJ0TnWJvjOKi1U/5Pf4eNM20BLR8ZeXW3MJzh8YW7lfJa5LxMT2Kg/3/3S9p6CDb+LXxsB3DiK0kMA2bWMVWZxdw0yZ4ePd4XteZ6Ew/u0oRrRHx6ehKU68ecSI3dFHc4bWPDHkvuTpd0/BPLhZZRdvcbmqUupVgr3J4UmAGOL0N5Tdhrqk4U2YlNTgqXAZCXkLte5/fALgJiZ16L2zjG8MWpTsbMsbAODtGpjUad2ZxU042SjJYWdIknu0qL33FR2QZVVLWINADEbdcFDV5kL6bt+dPDqLFqqsnrd5ea7xoBnzJRs7541ItvGbAlfeaBQJN1/F7HBptUmPz4s9t4aPRg5rsZVIdGr6YXvugtBsyL1aDCGSDuqWZ9M/gNTpt3AidBrnlPQc6tkq+l1t873526pHLUpZGxhupZAQ5blT8iPBGF3+eGd5cuRLTfPs5a05D5foKATtLErgkEmAepmV5H8r85L+pxcX1FMSwoee3WM8oO2JrJcfs+N0XnUf/uUmdsM+aoARbtkFBC8GxY/bV/QQABdftnwyfU2fnxbZoZVnwawRziTTCr1rhG3CUaSxXuX6aMFtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6916009)(66476007)(54906003)(2906002)(64756008)(66446008)(53546011)(38070700005)(85182001)(66946007)(7416002)(8936002)(76116006)(71200400001)(66556008)(122000001)(5660300002)(26005)(38100700002)(52536014)(83380400001)(7696005)(33656002)(186003)(55016002)(508600001)(316002)(86362001)(8676002)(82960400001)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXByU1IwZjcvZXQ5WUJlMm15WnV4aUdTVTV2MkRQRFQ1cXR3SXZkNFA4REFh?=
 =?utf-8?B?RjBqdFpyTDNJWmxKOUl5QVUydnhoMmRCNnlNNDFMOW9sdkxmRmxQcmNjS0Zq?=
 =?utf-8?B?OHJyaU9LYTdPYUNyTkkrNlArTTRHc09xQmxHejlUaTdmd2lhQmZHdkZlanlp?=
 =?utf-8?B?eTgyLzVQUVA0N2RvZTUxRUdGaWZCRUR0UVhuUFR6SFhnY2ZLa1ZhSHFLSUNh?=
 =?utf-8?B?OEt3NmRhRURHUGZiV0lhT3pPSERsMGw5enEvcVgydHlmblMyYW1LTjVhRksr?=
 =?utf-8?B?TnhFQVVaVWphekpXYWZubWxBUzE2NVhGK0xTbGFWKzR3b2hoT3JKRTdFZEVZ?=
 =?utf-8?B?TDFPZ3N6bXYvYTYwMm8yUC82c0NZVStnZlF6ZFVMbXVBYWovUGdEbGRJV2pu?=
 =?utf-8?B?U2NlYUJSSnVoMG8ySENsR2t5Mi9PbWl4S01CNXZuQ09peHFRemcxQk8vMkdi?=
 =?utf-8?B?cUgyZ3lHc2FyY0xxQXBJdkZlTFV3VThmeXphaGg3eTdmK0RzTU40NjRJMlZ2?=
 =?utf-8?B?MHkveTVlNHdUcExpdjBoWW1mVVl4UXBKTWJaaUp1Qzl1bUZVQW11T2FOcVdk?=
 =?utf-8?B?YWlua0JxNVUzTTlOcnlxbFR6RjB2LzErZlNyeUJFZnVGVTNzM05KTWZ6Z3dq?=
 =?utf-8?B?S2JCRGpvRWhTU2k1ZFY2Z3pVVFZ0bWY5RkMrYmcxanhUdUhpRjRlWDZYcE1P?=
 =?utf-8?B?YS8vcDRNaVZhc1owZ2VoYkdrR3JlRzgvY0k1bG4vU0djVkxSZlNQWndrSUpL?=
 =?utf-8?B?cjhVRUFaQzdMRTQvZGVNZUNkYW1rcnV5eXdSQUlBek9NKzFFK1dNMDhPcE1s?=
 =?utf-8?B?WDZydzlKVXZ6b1FDT0hlcXNhYnppV3ZxbWlpZm1Ca25DWTJKVURyN0FOejlG?=
 =?utf-8?B?K3BQM2h1N1gyc1JFY1gvdmhFandUMld6ZUhuamIveHUxaG9ZODB6L2NYSW5S?=
 =?utf-8?B?NUR5KzJrQzBJYmI1a2NvM0sxVkpYdTN3SXZXWHNUWmpCZmlEN3lCUWlZakhV?=
 =?utf-8?B?TFZKekw2ejBmUTM4VDJMeFpmek1VUG1YaGlZTmdkT1ZNR2xsUzVLZWtpeVdB?=
 =?utf-8?B?LzE5cnlPQnZ0bWZWdENRWmhMY294bGhhakNwMWVnSk9VWDI3SjNjUTQxY2lv?=
 =?utf-8?B?Uzd2RVI1eERHenlIWW50VGovTmU5ZDhwcERoWnNWZzZxM0FBT0g0MjJseEpm?=
 =?utf-8?B?eVlOYTVWN2ZIb1VNRS9aK0N1REZkUFVkSk9zNFBPWU5ncHFlZjNZVEp5eWdS?=
 =?utf-8?B?L1RBRUw0cE90NEFFM2RrWkovTjBodXRURmtwUno2Y3d1TjgwRjlJYks1UUZI?=
 =?utf-8?B?L0VOekwrQ1h0TWJtQkNmM1B5ekFPVXVjYXRaNUZXYmpZekxDa1c1OWxnWHdt?=
 =?utf-8?B?TjRCcDZ0b2dVKzFVTjh2SGFIa1FVRFVYdDRzQ2MrQXpEanh2dGlLWXVZYWcz?=
 =?utf-8?B?dXp6NEpqTUNpUWNySGxkZFh3WjFqa21jbXhBK3FwOVlGUlA4SUthSjEzaFVZ?=
 =?utf-8?B?bWlNZnFRdElxUDFucFNjMzlWNXR1Z09PUWhlVUxWZDIwdDR3S3U0SzFRSjds?=
 =?utf-8?B?Z01kS25CdUN0Ukk3aUZaSWJvWjEzSGpYcGFrTnFnNHpmeDUzc3pXdzVQV1lw?=
 =?utf-8?B?MlNwNkR1QW5Bc29sT2pWWHFURnJveGYrL2Fsd013Z292bjROdDJpSEYybW4r?=
 =?utf-8?B?S2gwNzJVTllaTm1Xb0tTVGlCNm9HQ0VpU294dnY3dTNaOGhwZGZjci9rRCs1?=
 =?utf-8?B?VVBmQTc1R2RCZGxRdXc2K21tSlJKSDRZTm5NRWNBQmZRWXNzOWM2YlEwWURo?=
 =?utf-8?B?U2pTaEdJd0dNMFJTZWNlMjJhZ2pkNm55b2dVTzQ3TlNoWWlQMlV6VmpHZ21M?=
 =?utf-8?B?dHdWRjEzY1V0dmRnMjdrVk1yemEzUHhTK085eHRWOCtYUkFGaGFFWXRERlBk?=
 =?utf-8?B?WmZhVXlJQm0vVXJUTFA4R1pldEJkbGt2N296ZFlUdEpBb1BWelRLNEtNTjhI?=
 =?utf-8?B?SWQxeTh1WFVmOUQzL0t3TTdpelYrVksxMk81aDZtQURvTUlGREhSZmRoemts?=
 =?utf-8?B?ZTMrQ2FVTU5uUFZVcUExZlVoM3MvbVBoT3lTcHFJVHQ2d3VRUjEwTXJoNEJO?=
 =?utf-8?B?aVZkMnhGeXE4dVhWSnNhb09zWUdHMlcrdUVNNm5CanZVSlhpb2wyNExNV3ht?=
 =?utf-8?B?TXRFSGRLU05zZ1V0WU92YldJVTJpRFgrWEpQUlJRRWRSQUhRMFIrTENzeW1w?=
 =?utf-8?B?L2JJd1NBb09CNW5SdkJhdW5Jdk9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d54dd3-0a48-40e8-2776-08d99fe9ee4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 23:22:12.2661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXn7CyUtv/OvbgqZV3MNxzmCGp70ODNF5FBYi7tdGAKJdeUvnzcEwqOXmqunl21BsvANGvz4z3DMo0jFoQWdwxSLLyqK1UxIr1W5Q4fozDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3358
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksIFJhZmFlbC4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KV2Ugd2lsbCByZXNw
b25kIGFzIHlvdSBzdWdnZXN0ZWQuDQoNCkJlc3QgcmVnYXJkcywgDQpTaHV1aWNoaXJvdS4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA0LCAyMDIxIDg6
MzEgUE0NCj4gVG86IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo5LiA6YOOIDxpc2hpaS5z
aHV1aWNoaXJAZnVqaXRzdS5jb20+DQo+IENjOiByandAcmp3eXNvY2tpLm5ldDsgbGVuYkBrZXJu
ZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgcm9iZXJ0Lm1vb3JlQGludGVsLmNvbTsNCj4gcmFmYWVsLmoud3lzb2NraUBp
bnRlbC5jb207IGRldmVsQGFjcGljYS5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+
IGd1b2hhbmp1bkBodWF3ZWkuY29tOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFDUEk6
IEFkZCBBRVNUIGluIEFDUEkgVGFibGUgRGVmaW5pdGlvbnMNCj4gDQo+IE9uIFRodSwgTm92IDQs
IDIwMjEgYXQgODoxNCBBTSBpc2hpaS5zaHV1aWNoaXJAZnVqaXRzdS5jb20NCj4gPGlzaGlpLnNo
dXVpY2hpckBmdWppdHN1LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBwaW5nPw0KPiA+DQo+ID4gUC5T
Lg0KPiA+IFdlIHNob3VsZCBoYXZlIGFkZGVkIHRoZSBtYWludGFpbmVyIG9mIEFDUEkgRk9SIEFS
TTY0IChBQ1BJL2FybTY0KQ0KPiA+IGZpcnN0LCBidXQgc2luY2UgQUVTVCBpcyBhbiBhcm0tc3Bl
YyBBQ1BJIHRhYmxlLCBhZGRlZCB0aGUgY29uY2VybmVkDQo+ID4gcGVyc29ucyBhcyBuZXcgZS1t
YWlsIGFkZHJlc3Nlcy4NCj4gDQo+IFBsZWFzZSByZXNlbmQgdGhlIHBhdGNoLCB0aGVuLCB3aXRo
IGFsbCBvZiB0aGUgcmVxdWlzaXRlIGFkZHJlc3NlcyBwcmVzZW50IGluIHRoZQ0KPiBDQyBsaXN0
Lg0KPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTaHV1
aWNoaXJvdSBJc2hpaSA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tPg0KPiA+ID4gU2VudDog
VHVlc2RheSwgT2N0b2JlciAyNiwgMjAyMSA0OjUzIFBNDQo+ID4gPiBUbzogcmp3QHJqd3lzb2Nr
aS5uZXQ7IGxlbmJAa2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByb2JlcnQubW9vcmVAaW50ZWwuY29tOw0K
PiA+ID4gZXJpay5rYW5lZGFAaW50ZWwuY29tOyByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsg
ZGV2ZWxAYWNwaWNhLm9yZw0KPiA+ID4gQ2M6IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo
5LiA6YOOIDxpc2hpaS5zaHV1aWNoaXJAZnVqaXRzdS5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUEFU
Q0hdIEFDUEk6IEFkZCBBRVNUIGluIEFDUEkgVGFibGUgRGVmaW5pdGlvbnMNCj4gPiA+DQo+ID4g
PiBXaGVuIFdlIGFkZGVkIEFFU1QgdXNpbmcgdGhlIFVwZ3JhZGluZyBBQ1BJIHRhYmxlcyB2aWEg
aW5pdHJkDQo+ID4gPiBmdW5jdGlvbiwgdGhlIGtlcm5lbCBjb3VsZCBub3QgcmVjb2duaXplIHRo
ZSBBRVNULCBzbyBXZSBhZGRlZCBBRVNUIHRoZQ0KPiBBQ1BJIHRhYmxlIGRlZmluaXRpb24uDQo+
ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1dWljaGlyb3UgSXNoaWkgPGlzaGlpLnNodXVp
Y2hpckBmdWppdHN1LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvYWNwaS90YWJsZXMu
YyB8IDIgKy0NCj4gPiA+ICBpbmNsdWRlL2FjcGkvYWN0YmwyLmggfCAxICsNCj4gPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvdGFibGVzLmMgYi9kcml2ZXJzL2FjcGkvdGFibGVz
LmMgaW5kZXgNCj4gPiA+IGY5MzgzNzM2ZmEwZi4uYWIwZmI0YzMzZTA3IDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9hY3BpL3RhYmxlcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkvdGFi
bGVzLmMNCj4gPiA+IEBAIC00OTksNyArNDk5LDcgQEAgc3RhdGljIGNvbnN0IGNoYXINCj4gPiA+
IHRhYmxlX3NpZ3NbXVtBQ1BJX05BTUVTRUdfU0laRV0gX19pbml0Y29uc3QgPSB7DQo+ID4gPiAg
ICAgICBBQ1BJX1NJR19XRERULCBBQ1BJX1NJR19XRFJULCBBQ1BJX1NJR19EU0RULA0KPiBBQ1BJ
X1NJR19GQURULA0KPiA+ID4gICAgICAgQUNQSV9TSUdfUFNEVCwgQUNQSV9TSUdfUlNEVCwgQUNQ
SV9TSUdfWFNEVCwgQUNQSV9TSUdfU1NEVCwNCj4gPiA+ICAgICAgIEFDUElfU0lHX0lPUlQsIEFD
UElfU0lHX05GSVQsIEFDUElfU0lHX0hNQVQsIEFDUElfU0lHX1BQVFQsDQo+ID4gPiAtICAgICBB
Q1BJX1NJR19OSExUIH07DQo+ID4gPiArICAgICBBQ1BJX1NJR19OSExULCBBQ1BJX1NJR19BRVNU
IH07DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgQUNQSV9IRUFERVJfU0laRSBzaXplb2Yoc3RydWN0
IGFjcGlfdGFibGVfaGVhZGVyKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Fj
cGkvYWN0YmwyLmggYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmggaW5kZXgNCj4gPiA+IGE0N2IzMmE1
Y2JkZS4uYjU4NmU0MGQ0Yjg2IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjdGJs
Mi5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgNCj4gPiA+IEBAIC00OCw2ICs0
OCw3IEBADQo+ID4gPiAgI2RlZmluZSBBQ1BJX1NJR19TREVWICAgICAgICAgICAiU0RFViIgICAg
ICAgLyogU2VjdXJlIERldmljZXMgdGFibGUNCj4gKi8NCj4gPiA+ICAjZGVmaW5lIEFDUElfU0lH
X05ITFQgICAgICAgICAgICJOSExUIiAgICAgICAvKiBOb24tSERBdWRpbyBMaW5rDQo+IFRhYmxl
DQo+ID4gPiAqLw0KPiA+ID4gICNkZWZpbmUgQUNQSV9TSUdfU1ZLTCAgICAgICAgICAgIlNWS0wi
ICAgICAgIC8qIFN0b3JhZ2UgVm9sdW1lIEtleQ0KPiA+ID4gTG9jYXRpb24gVGFibGUgKi8NCj4g
PiA+ICsjZGVmaW5lIEFDUElfU0lHX0FFU1QgICAgICAgICAgICJBRVNUIiAvKiBBcm0gRXJyb3Ig
U291cmNlIFRhYmxlICovDQo+ID4gPg0KPiA+ID4gIC8qDQo+ID4gPiAgICogQWxsIHRhYmxlcyBt
dXN0IGJlIGJ5dGUtcGFja2VkIHRvIG1hdGNoIHRoZSBBQ1BJIHNwZWNpZmljYXRpb24sDQo+ID4g
PiBzaW5jZQ0KPiA+ID4gLS0NCj4gPiA+IDIuMjcuMA0KPiA+DQo=
