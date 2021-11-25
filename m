Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB71545D7AF
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 10:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbhKYJ4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 04:56:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:49063 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348015AbhKYJyr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 04:54:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="216193450"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="216193450"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 01:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="498012157"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 01:51:33 -0800
Subject: Re: [PATCH v2 0/7] ACPI: acpi_device_override_status() changes
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20211122170536.7725-1-hdegoede@redhat.com>
 <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cecea505-9a30-7114-3d3e-80856cccb6c4@intel.com>
Date:   Thu, 25 Nov 2021 11:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 23/11/2021 13:13, Ulf Hansson wrote:
> On Mon, 22 Nov 2021 at 18:05, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> As requested here is a v2 of my series previously titled:
>> "ACPI: scan: Skip turning off some unused objects during scan"
>>
>> Which was a regression fix series for the commit c10383e8ddf4
>> ("ACPI: scan: Release PM resources blocked by unused objects")
>> change, but that has been reverted now. So as requested here is
>> a v2 changing the wording of various commit messages since these
>> changes are still useful to have regardless.
>>
>> Patch 1/7 is a v2/resend of the "ACPI / x86: Drop PWM2 device on
>> Lenovo Yoga Book from always present table" patch. You requested
>> changing the commit message of this one a bit to make it sound
>> less like a regression fix (which it is not). But you already
>> have the previous version of this patch in your bleeding-edge
>> branch, with a "Cc: 5.1+ <stable@vger.kernel.org> # 5.1+"
>> added ?  So depending on which version you want you can either
>> skip this patch when applying this series, or replace it with
>> the version from this series.
>>
>> Patches 2-4 are the main changes to make the always_present
>> quirk handling more flexible, changing it into a status_override
>> mechanism + adding a quirk for the GPD win and pocket to fix
>> an issue with those in a more elegant matter then the current
>> kludge in the sdhci-acpi code.
>>
>> Patch 5 is an unrelated patch which touches the override-status
>> quirk table, so it needed to be rebased and I decided to add it
>> to this series to make it clear that its v2 needs to be applied
>> on top of the other ACPI changes from this series.
>>
>> Patches 6+7 cleanup the sdhci-acpi code, removing the now no
>> longer needed ugly kludge for the GPD win/pocket. These can
>> be merged independently from patches 1-5, through the mmc
>> tree, as long as they get send to Linus during the same
>> kernel cycle as the ACPI bits.
> 
> This sounds like the mmc changes are really not that independent after
> all. What about bisectability?
> 
> An option is to funnel the sdhci patches together with the ACPI
> patches through Rafael's tree. You have my ack for this, but let's
> wait for Adrian's ack too.

Looks OK to me.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
