Return-Path: <linux-acpi+bounces-21187-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPG6HgcjoGkdfwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21187-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 11:40:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08C1A46AC
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68FAC301B86C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C13A9D83;
	Thu, 26 Feb 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mARa/vGy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB243A1D1C;
	Thu, 26 Feb 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102401; cv=none; b=AY3HinzdcekSFRSDz1hbPAA1YtDZly8yGb4t0KlaAEttSLZCIMCOsmM3WTULSYoX//MRT8ghwdHgM2sx1wLaFGytcJ7p3DCzXbYPZ3fGBCWK8n6Tt1YPlmwo75SdcEcHJdJkaRS2BmxN1t8J1iLW5PDKOunt4pBBQgTSqRnsAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102401; c=relaxed/simple;
	bh=+aJzA5ViUvlKgBJcGoAel/ZoO/g+kP6obBbuX3CEJnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWZKX4QQFQnf5JQ4JJEMbG+OodMmr7dVmzBR98E8kb8mBFfxCa0zGJpeC+SMHnn+GIx/7eDrYIktko9eGTAcup7t/V8P4fkxru2CxlJwesTSOEdAjplYoOLAKvwFnse5uINAH7OIHUsoW/lr2BLwvzEM2dCzqlmOlXsLkdrEVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mARa/vGy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772102400; x=1803638400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+aJzA5ViUvlKgBJcGoAel/ZoO/g+kP6obBbuX3CEJnc=;
  b=mARa/vGyiIeHL3gcr+RSjecImzvHinF066eYKoRTCZ6HF4g97FuErEep
   4wzK9+n1/h8o8SwNY76F1cGKV6SbarFjjmC7xRinD+JQGoK8piEN7fqbc
   3YAfLIktmFDl2TlH8av3xYsJCi87+O+lNBgK+jBfXTN3Je22Me65tHCiv
   4NEQFmxoDGm2LhlCi8yCewpnnZ8cNkafCzY8AArvKVXEHKc5v/PhUmr8U
   gZq9ZBO4P1FMYIoQaDTPwWcYTxArwxfwGsw9mxnmYPijDCQ0Cyacna0Vz
   TJJAnvkwuk/cImbw6sb59bQO/5FDSoXqVRMc1xmtO6t6nRc+GI0inRS/x
   A==;
X-CSE-ConnectionGUID: 84UkzyWwSIW8XFefDRGnHw==
X-CSE-MsgGUID: RCoYr/94TkCncS9IEGIN9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="90569119"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="90569119"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 02:40:00 -0800
X-CSE-ConnectionGUID: bHa6tfM2RPOqdqOJqXaCcQ==
X-CSE-MsgGUID: 6JjRpUMQRcSwLZy9aB7i7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="216433257"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.210])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 02:39:55 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0D1F311FA45;
	Thu, 26 Feb 2026 12:40:23 +0200 (EET)
Date: Thu, 26 Feb 2026 12:40:22 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aaAjFkGEhTDkbEXD@kekkonen.localdomain>
References: <20260226-device-match-secondary-fwnode-v4-1-27bd0cfbd8c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-device-match-secondary-fwnode-v4-1-27bd0cfbd8c6@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21187-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,qualcomm.com:email,kekkonen.localdomain:mid]
X-Rspamd-Queue-Id: 1A08C1A46AC
X-Rspamd-Action: no action

Hi Bartosz,

Thanks for the update.

On Thu, Feb 26, 2026 at 10:56:36AM +0100, Bartosz Golaszewski wrote:
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus

