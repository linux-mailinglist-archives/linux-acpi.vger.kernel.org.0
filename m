Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E99D2C8A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfJJO3B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 10:29:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfJJO3B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Oct 2019 10:29:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0170D9F904E22620CC3;
        Thu, 10 Oct 2019 22:28:52 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 10 Oct 2019
 22:28:43 +0800
Subject: Re: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields in
 Processor Structure Flags
To:     "Moore, Robert" <robert.moore@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
References: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
 <1570714192-236724-2-git-send-email-john.garry@huawei.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9691ADA@ORSMSX110.amr.corp.intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <efd1203b-ef81-a27e-8681-6eeabab75f8e@huawei.com>
Date:   Thu, 10 Oct 2019 15:28:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9691ADA@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/10/2019 15:22, Moore, Robert wrote:
> John,
> These #defines are all already in actbl2.h. Perhaps they didn't make it into Linux.
> Bob

Hi Bob,

Yes, they are in the latest linux mainline release.

But this patch is just a preview to backport them to an earlier kernel 
version.

Thanks,
John

>
>
> -----Original Message-----
> From: John Garry <john.garry@huawei.com>
> Sent: Thursday, October 10, 2019 6:30 AM
> To: catalin.marinas@arm.com; will@kernel.org; rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; sudeep.holla@arm.com; rrichter@marvell.com; jeremy.linton@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linuxarm@huawei.com; gregkh@linuxfoundation.org; guohanjun@huawei.com; wanghuiqiang@huawei.com; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; John Garry <john.garry@huawei.com>
> Subject: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields in Processor Structure Flags
>
> From: Erik Schmauss <erik.schmauss@intel.com>
>
> Commit b5eab512e7cffb2bb37c4b342b5594e9e75fd486 upstream.
>
> ACPICA commit c736ea34add19a3a07e0e398711847cd6b95affd
>
> Link: https://github.com/acpica/acpica/commit/c736ea34
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/acpi/actbl2.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index c50ef7e6b942..1d4ef0621174 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1472,8 +1472,11 @@ struct acpi_pptt_processor {
>
>  /* Flags */
>
> -#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)	/* Physical package */
> -#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (2)	/* ACPI Processor ID valid */
> +#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)
> +#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (1<<1)
> +#define ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD  (1<<2)	/* ACPI 6.3 */
> +#define ACPI_PPTT_ACPI_LEAF_NODE            (1<<3)	/* ACPI 6.3 */
> +#define ACPI_PPTT_ACPI_IDENTICAL            (1<<4)	/* ACPI 6.3 */
>
>  /* 1: Cache Type Structure */
>
> --
> 2.17.1
>
>
> .
>


