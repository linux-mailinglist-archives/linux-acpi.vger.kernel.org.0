Return-Path: <linux-acpi+bounces-792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FD7D0FBD
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AFA28056C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2941A70E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ksik9nfI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC619440
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 11:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A41213E;
	Fri, 20 Oct 2023 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697801897; x=1729337897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JePTitzuY0GQtcJN+j6l1yJWlx9JL0zZgTWlbLVx8N8=;
  b=Ksik9nfIDemqOWvDHAgyjBxp1T2qeJmtINxn/8gEWfZfd7LrdZ5WQqFB
   g0dN9j/J8IPgoGqzwiQYN7yk/Lr9rDnCHwtfixSU4toI5ZDEfFg3TrE9P
   lbhTWMZ7V8B2xrU7eGqkNsf1WxREJdeorInhHrgGveMDQftUF4eosUDgL
   To/mjGOr5S/3koG/YpYXG7FbM14yOimSrMVOOrT/6UOu605+XSru7p76+
   tKPgvJaWppYxDuPqzBTVfJmcRdO2L+xqjFXypeONYjjWjcNlztYQmRlYf
   lMHCkYMaA1Y83xuNyFDPOE9GyUp1BC4vKYrwD3kd/BO2dBi8Y75os2N5J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450707539"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450707539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 04:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="901121259"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="901121259"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 04:35:59 -0700
Date: Fri, 20 Oct 2023 14:38:06 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJYK02w8HZg26eI@smile.fi.intel.com>

On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use standard ACPI helpers.
> 
> Yes, while not so obvious this is the correct replacement.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think this is the only case which would suffer from the more obvious
behaviour, i.e.

bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
{
        const char *uid1 = acpi_device_uid(adev);

        return uid1 && uid2 && !strcmp(uid1, uid2);
}

That said, we can't be particularly sure about it's potential future users,
especially when the usage will not be limited to just ACPI core since we're
exporting it.

Raag

