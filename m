Return-Path: <linux-acpi+bounces-21547-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDKYGjTUrmlhJAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21547-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:07:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01F23A45B
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 269623008E01
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596513AEF37;
	Mon,  9 Mar 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb2YeIl7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFE3BED42;
	Mon,  9 Mar 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065228; cv=none; b=ojurA/Ea6KFXcMO6OtDQLHgPB2nIBWL6slBCxA58c08Ni8uoEFM96jAjih5moKYmsHOrGJoyisvpEsmJ6tukC+BiJd4ecOD5DduhKjMsQZq0J+6/CSIe4Y4k5pxwVKSnz0c0CHSufa0sK7I9F19DErcxXP75lWoz4EVBP4qsklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065228; c=relaxed/simple;
	bh=ShIAhwVVtjh3OdHVVabqkqR3uIA8+RPqViH6SmuT9kY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OrE80BOtHyLxwjzMiVss1hU2zJr5Ma1LGWMrW7Qp+/1UGnjXrnETzo/7kbF2LkhVecqCBahXEcNXstELSxn80c3ga4qPkGNk/EZa7TIOuF/iW3Lyes2FT8xBMcmBMX8fQPnCpmF8UkozBP+pyU92I3bPC9tPizZW/mnTflxEeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb2YeIl7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773065227; x=1804601227;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ShIAhwVVtjh3OdHVVabqkqR3uIA8+RPqViH6SmuT9kY=;
  b=bb2YeIl7/UaQA7OAUePvZ1wmtbgSdjGhdNmLckVvuwMzXsvx6Qy8NEPI
   7DlcFOuCeYkh3+Z81Unu3+4ObTdaNnFwABeE6Tbn9dYgNAkDwvo+Fcfm/
   fVD7CU88xmleoLrdART8438pBZ6p9lN8jw9899TFhayXnA5Ehv4H6hSJ7
   lp0ZrwcUXkcVDkVmm5zECtyE9bBWqztWcj7dzDPsZyC3jMuBgwcG5NEdH
   1j34lI7nxYZlcmUw8fQhweT8zRlSjjIcv2yfQumD1HxOz+kUZrMfrw4pj
   01FyypUgUniTwL4bFqlktAana5XC3KXr2NCAVEQXOas2UsEsUmmy9Iq47
   A==;
X-CSE-ConnectionGUID: PsESDyQAT4+hlFRP1Dav3Q==
X-CSE-MsgGUID: wH0+HnnQQkiOJ7WzsDuDqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74008256"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74008256"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:07:06 -0700
X-CSE-ConnectionGUID: nJXXFNH9Tkiha2wn9+e6jA==
X-CSE-MsgGUID: SBt+UGRcQi+rwoa+QbdJxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218911885"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:07:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 16:07:00 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 2/3] platform/surface: surfacepro3_button: Register
 ACPI notify handler
In-Reply-To: <1881356.TLkxdtWsSY@rafael.j.wysocki>
Message-ID: <461da326-7a86-552e-4d2e-9b7730bc1699@linux.intel.com>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki> <1881356.TLkxdtWsSY@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: EE01F23A45B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21547-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/surface/surfacepro3_button.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
> index a6c9d4d370be..6d394daf5bc4 100644
> --- a/drivers/platform/surface/surfacepro3_button.c
> +++ b/drivers/platform/surface/surfacepro3_button.c
> @@ -72,8 +72,9 @@ struct surface_button {
>  	bool suspended;
>  };
>  
> -static void surface_button_notify(struct acpi_device *device, u32 event)
> +static void surface_button_notify(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *device = data;
>  	struct surface_button *button = acpi_driver_data(device);
>  	struct input_dev *input;
>  	int key_code = KEY_RESERVED;
> @@ -227,6 +228,15 @@ static int surface_button_add(struct acpi_device *device)
>  		goto err_free_input;
>  
>  	device_init_wakeup(&device->dev, true);
> +
> +	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +						surface_button_notify, device);
> +	if (error) {
> +		device_init_wakeup(&device->dev, false);
> +		input_unregister_device(input);

Add a new label to rollback path instead.

> +		goto err_free_button;
> +	}
> +
>  	dev_info(&device->dev, "%s [%s]\n", acpi_device_name(device),
>  		 acpi_device_bid(device));
>  	return 0;
> @@ -242,6 +252,8 @@ static void surface_button_remove(struct acpi_device *device)
>  {
>  	struct surface_button *button = acpi_driver_data(device);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       surface_button_notify);
>  	device_init_wakeup(&device->dev, false);
>  	input_unregister_device(button->input);
>  	kfree(button);
> @@ -257,7 +269,6 @@ static struct acpi_driver surface_button_driver = {
>  	.ops = {
>  		.add = surface_button_add,
>  		.remove = surface_button_remove,
> -		.notify = surface_button_notify,
>  	},
>  	.drv.pm = &surface_button_pm,
>  };
> 

-- 
 i.


