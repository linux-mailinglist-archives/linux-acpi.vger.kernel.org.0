Return-Path: <linux-acpi+bounces-21549-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMmWITvgrmmoJgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21549-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:59:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F5123B22F
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F4DA3019FDE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AF3D668B;
	Mon,  9 Mar 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyaSBFDZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B37B640;
	Mon,  9 Mar 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068293; cv=none; b=VBjciBc1kV9v1Is9JqX7zIGSdBz6bFSotS0V9dmvTGp2gv2WL7i2l847b/A9BKIdtjtBUzEENlGStufAcKBWSh/GtTFxMMqxskM+a8Rboat08qZJganE3ZBdf0BMgcyEQgRL/WMNvbRzw8k0jYoa4iQTH9DNEp1rD+olu9WWjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068293; c=relaxed/simple;
	bh=Qx/owJz8d3fobLL6i67Jjz4QpnzQGte9XG0MbYDh31w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tNI0LsUa6ZqhxodLYlroi4S6QyydA4id7nfBpnF5k1KksVGYGZvaOB0BGnPjcD0DqjRJy3yX6CWoWCP6gJnED/Z2eZBHtIliFc3GX4cKjYnStlfDUVWE8ALNOwRIGnyrJVqg9DYSLr6mCksOyuOc+zf6MW9j3z0yRoiJjYQdDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyaSBFDZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773068292; x=1804604292;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Qx/owJz8d3fobLL6i67Jjz4QpnzQGte9XG0MbYDh31w=;
  b=EyaSBFDZ/FRaWtvMFQr/n1mdSUDvizSR+0QfdKs+T6kWDXy6CII+2k0o
   cwIxE7M9ickqVQYxavEoX37KUjRCwSC1r0FJGKIrFuSyEC9lUaBBBd49Z
   KFIfj6tbs2GdavTJpOl+yr8P7P9+/L0L9IPeLH4psdy6jkcAV5cCvR+sQ
   hKCqjGr4YOgIWzylHG3chH2YHktxZC9EDm68xHnRVuezIurDMs7Lfq7Is
   46MgPrw+0+WGSQoCWUmDX+t26x6URLjWJ66mQsJ7M0lakPI4ftFeYqvXK
   isxbVZ0bfVcncNoR4kymBBwAf5ieT40sd/pFLgzHc5z3teRarB8rzGI2I
   g==;
X-CSE-ConnectionGUID: uqWtg7GkQPqVN0ZfFZAwrQ==
X-CSE-MsgGUID: y4VY7u/OQcW+8bnG17dWow==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74202396"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74202396"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:11 -0700
X-CSE-ConnectionGUID: Sp9wPBrrSVKZFIvl7fxYDQ==
X-CSE-MsgGUID: eiZidno7Q8SCc2aLTmpCSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218985715"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <3406021.44csPzL39Z@rafael.j.wysocki>
References: <3406021.44csPzL39Z@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: acer-wireless: Bind to a platform
 device instead of an ACPI one
Message-Id: <177306828103.16654.17935127898460117105.b4-ty@linux.intel.com>
Date: Mon, 09 Mar 2026 16:58:01 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: C9F5123B22F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21549-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 16:17:06 +0100, Rafael J. Wysocki wrote:

> This series is part of a larger effort to switch over all drivers using
> the struct acpi_driver interface to the more common struct platform_driver
> interface and eliminate the former.  The background is explained in
> Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
> the patch that introduced the above document:
> 
> https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: acer-wireless: Register ACPI notify handler directly
      commit: 6fdc70794cc15b450e3fd750ca048318764a343e
[2/2] platform/x86: acer-wireless: Convert ACPI driver to a platform one
      commit: b30a462720ad15613ede9e365938d401ed464095

--
 i.


