Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC4C3059
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfJAJi7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 05:38:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:55225 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfJAJi6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 05:38:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205032539"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 02:38:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 12:38:54 +0300
Date:   Tue, 1 Oct 2019 12:38:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ACPI / utils: Introduce acpi_dev_hid_uid_match()
 helper
Message-ID: <20191001093854.GH2714@lahna.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924193739.86133-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37:36PM +0300, Andy Shevchenko wrote:
> There are users outside of ACPI realm which reimplementing the comparator
> function to check if the given device matches to given HID and UID.
> 
> For better utilization, introduce a helper for everyone to use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ---
>  drivers/acpi/utils.c    | 25 +++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  2 ++
>  include/linux/acpi.h    |  6 ++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index dbd1c4cfd7d1..804ac0df58ec 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -701,6 +701,31 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
>  }
>  EXPORT_SYMBOL(acpi_check_dsm);
>  
> +/**
> + * acpi_dev_hid_uid_match - Match device by supplied HID and UID
> + * @adev: ACPI device to match.
> + * @hid2: Hardware ID of the device.
> + * @uid2: Unique ID of the device, pass NULL to not check _UID.
> + *
> + * Matches HID and UID in @adev with given @hid2 and @uid2.
> + * Returns true if matches.
> + */
> +bool acpi_dev_hid_uid_match(struct acpi_device *adev,
> +			    const char *hid2, const char *uid2)
> +{
> +	const char *hid1 = acpi_device_hid(adev);
> +	const char *uid1 = acpi_device_uid(adev);
> +
> +	if (strcmp(hid1, hid2))
> +		return false;
> +
> +	if (!uid2)
> +		return true;
> +
> +	return uid1 && !strcmp(uid1, uid2);
> +}
> +EXPORT_SYMBOL(acpi_dev_hid_uid_match);

Should this be _GPL?

In any case looks good,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
