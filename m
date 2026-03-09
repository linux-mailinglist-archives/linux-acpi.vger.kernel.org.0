Return-Path: <linux-acpi+bounces-21552-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAf9LEfgrmmoJgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21552-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:59:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105523B24D
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4FB1302926C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D73D34B2;
	Mon,  9 Mar 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CY85pvVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B3A6EFA;
	Mon,  9 Mar 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068328; cv=none; b=ufN+KHs+nVAbM68cj9sefGwsx671ELomBVf7WE/BduWf1lMCJiU3NRJWwjEbVO/9xve2jyFq8tnb4EzFzAGqDeEaW95y6pov2hg3AHpvY1BC8thENtTsRcUVWG2DnRPrAeM3Y6CGesQUoTeaiqd/xx98womHqVxgLxE4k7yPOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068328; c=relaxed/simple;
	bh=okSSWpbzLyBK86pOVM++143etVdtW7co8wynItIKzmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OhKSNXbebJq42moswGPfPMM64dJfK7y2nk8mdn48jAM1erlOq+bUrwyBSb1ZZbtnSrxgArYNN5eO6AwkTbhl38/SdeqFI8zKZFqjTc5hOWuO/JctA61DNMx4r7jlO1ZnllfsDnbS88mLwEWWJrykCaEiCL5YZOB5yoPBrxEOo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CY85pvVL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773068327; x=1804604327;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=okSSWpbzLyBK86pOVM++143etVdtW7co8wynItIKzmU=;
  b=CY85pvVLsT+dZVpxvEvUrzY733JkeNZ2jrEQNvqZZwfijquDOyFaUju2
   RB7EVmnt34t1zn9jFLkqp0GeIny9Nf2PmTSGC34Otuin8Fp73Yrblqz0G
   VGheh/utQi3FSaNOfOT64s73ms5D7DBIHE1hn79AkAZbmO0pR/PzIoc+T
   iJLlYOpYrGwfnBlWMdwyx2BLxWlH9qbErtrMXVGB8h1FcTqtt0Iriwp5J
   ErlH6aLPWiiaDLf2uxDEV5sXUVDWVDkGwT4g7vZnOqmrtz2kF7H+3+3qJ
   oRSGt8t7CPn2k2XyEXwzlu7yeD1bBFk7MXuioqdHyWsiwcZpHJSgXkCwI
   Q==;
X-CSE-ConnectionGUID: fYxUCEqzSqej1zSz+KA0qw==
X-CSE-MsgGUID: H/LNFCqyTY2Saks2S8oZ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73793263"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73793263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:47 -0700
X-CSE-ConnectionGUID: MMu4ClhdQYOdRQICMt+57Q==
X-CSE-MsgGUID: ffpqe2vxRZCcuLV5sgk5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="250247017"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <2909929.BEx9A2HvPv@rafael.j.wysocki>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/3] platform/surface: surfacepro3_button: Use
 platform device for driver binding
Message-Id: <177306831900.16654.10683224775350972126.b4-ty@linux.intel.com>
Date: Mon, 09 Mar 2026 16:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 6105523B24D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21552-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 19:53:24 +0100, Rafael J. Wysocki wrote:

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
[1/3] platform/surface: surfacepro3_button: Drop wakeup source on remove
      commit: 1410a228ab2d36fe2b383415a632ae12048d4f3a
[2/3] platform/surface: surfacepro3_button: Register ACPI notify handler
      commit: 639d8c601c7a9aab44803245a22f6e3c365b08be
[3/3] platform/surface: surfacepro3_button: Convert to a platform driver
      commit: d913a5a12b4036e4219b02777d0a9c70e37a6620

--
 i.


