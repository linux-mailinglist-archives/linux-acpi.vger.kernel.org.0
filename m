Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212AE42C72
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438250AbfFLQhK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 12 Jun 2019 12:37:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:20710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438245AbfFLQhK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 12:37:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 09:37:09 -0700
X-ExtLoop1: 1
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2019 09:37:09 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.228]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.121]) with mapi id 14.03.0415.000;
 Wed, 12 Jun 2019 09:37:09 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Udit Kumar <udit.kumar@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: Help on named object in kernel 
Thread-Topic: Help on named object in kernel 
Thread-Index: AdUhB80T6nszZCo6R5C7RlLTfZjWmQANR+Sw
Date:   Wed, 12 Jun 2019 16:37:09 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
References: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzE5ZjY1YWItOGNhZC00ZWU5LTk0ZjMtODQ5M2MwYTAzYWRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmVFakVxd1hZTytiKzNtSG5SbjRrTjZBRU5mK0FlQW9BWTNhb05Ma0hERFJFcW5ldDRVeEFENGczak5HMVFuNSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Udit Kumar
> Sent: Wednesday, June 12, 2019 4:48 AM
> To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
> Cc: lenb@kernel.org; Rafael J. Wysocki <rafael@kernel.org>
> Subject: Help on named object in kernel
> 
> Dear ACPI experts,
> I need your help on defining named objected in ACPI under _CRS.
> In my firmware, I have defined two addresses for my device using
> Memory32Fixed and QwordMemory under _CRS.
> These  two addresses are 32-bit and 64-bit long respectively.
> For Memory32Fixed, I gave DescriptorName name as REG0 and for
> QwordMemory I gave DescriptorName as SATA.

Could you give us the ASL for the code snippet that you're talking about?

Erik
> 
> In Linux, all of resource of this device is added under its name (NXP0003:00).
> Reading r-> name for all resource of this device is giving name as NXP0003:00.
> So I am not able to use existing OS driver using call
> platform_get_resource_byname, I have to use platform_get_resource API
> with index to get above addresses.
> 
> Could you help me, if there is way to use named resource in acpi.
> Fyi, I am on kernel 4.14.122
> 
> Many Thanks
> Udit
