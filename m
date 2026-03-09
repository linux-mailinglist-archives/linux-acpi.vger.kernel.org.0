Return-Path: <linux-acpi+bounces-21550-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJmPGOLgrmnsJgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21550-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 16:01:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E00BB23B2DC
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DDC4305F49B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841F03D6465;
	Mon,  9 Mar 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8tfPQBx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56DB640;
	Mon,  9 Mar 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068310; cv=none; b=pZE4k4a1wkyGkgcswmwQOCwegZbBf3THiIJ8B2ZLjLnvlBKBLweJ+SKmFVU6hLolV9bGaQJ2Z1fmi4YBH7Xxf1gm6TrPtpmdNWEwJQiHIzUUdm4ccRly33J2065DoKgy8bj/4x2AALhIlUXz5lJ3FCUFpgKYuleMudJ2e7XP88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068310; c=relaxed/simple;
	bh=BhGr71w09jAMTeEaYHpWv9Xr9kBR2gQLnKinHvAplgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dUh43yH9SWt4dOwA+ClemteO++tFz/FSxH1e9i5i7Nbp+lex7biTNVSApCz9+JIaxhMoXVVeScO2Te44ARdC48wxCdygQGJy9WNvIby+fZj04v9/qQMgJ+QMV1dtClA3nap7jZ23PAESzxLb35cKighudyKAh57LAnRiFMko1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8tfPQBx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773068309; x=1804604309;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=BhGr71w09jAMTeEaYHpWv9Xr9kBR2gQLnKinHvAplgE=;
  b=G8tfPQBxgGZgYct7D0Sbmn+gWyPTw2fwx3D7uOWJwVNZx17RVZVPIbCA
   gaEyfyBAGZNtz6qGbgeo2l3Lr687l7MaVfsf9aKiVG8Qy/V3yGQpm/lfb
   qCSVGfbfflNmfxNmklqpCSDrW9fFiUvVqlN7KlwIsyk/Z2/8WqxNSgi6X
   7MEPQzccS9FJK3YiqVP9Yxth1g4ac6TQhuxmfVRD9K7v1gyUHcM3MGqv6
   bgpaylIRHQhP7dOQu9EJm4TgGKi1KOY3ZLr6xkZeqTIRevFdgd1tnT8Qa
   qiQwucwByF/0BaQZDPBDKhf4OI9UK3DR8wAWB43koQn0m76VgkK6LC0rr
   g==;
X-CSE-ConnectionGUID: g1Slk8xNRb2SUE/z8uUmZA==
X-CSE-MsgGUID: oEtEPFqKTIWW6bVcEHBijA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74202428"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74202428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:29 -0700
X-CSE-ConnectionGUID: /OKIAWReSWGaJxIyTaSHlw==
X-CSE-MsgGUID: RVlXI3pNRXOEjdVoM+NSZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218985757"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <7916328.EvYhyI6sBW@rafael.j.wysocki>
References: <7916328.EvYhyI6sBW@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: eeepc-laptop: Bind to a platform
 device instead of an ACPI one
Message-Id: <177306829122.16654.10223916545743622881.b4-ty@linux.intel.com>
Date: Mon, 09 Mar 2026 16:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: E00BB23B2DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21550-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 16:21:17 +0100, Rafael J. Wysocki wrote:

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
[1/2] platform/x86: eeepc-laptop: Register ACPI notify handler directly
      commit: 5eea33b4d301e279abe49cdbd28f8be24e8932a1
[2/2] platform/x86: eeepc-laptop: Convert ACPI driver to a platform one
      commit: 079b59fd2d79e4f492cba7013c5f60787d573fc8

--
 i.


