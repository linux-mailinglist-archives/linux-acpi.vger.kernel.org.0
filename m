Return-Path: <linux-acpi+bounces-20624-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDfXDBKCd2m9hgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20624-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:02:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E643A89E29
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E30943052347
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44343335072;
	Mon, 26 Jan 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SB4ggybQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8D155757;
	Mon, 26 Jan 2026 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439443; cv=none; b=bimTwUayf/lektxk7n+y2N45OC/9NdHfAcXzZEes1++MoUEJMyBghsrQF7HjbWlvt1UbZo/9Vdzqs3tvBkHXd3NJYB7OfTddJUPVf4I/ZSKT34ZQlkB405unMfSAGhC+DhRmX01ns/Th5PbfsSozTP8lY804L6wYJ2ZOW0WV3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439443; c=relaxed/simple;
	bh=pV6+UeigcM+FGxdIo+s+rhMmnmFEIsga5wQGALUEZ0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=do7/74OdEWE5rSHFEMtWxKqOGeInwOqsmdsE6681M8X5iC4GnGUNMtpmkIT8NcfnIVAwVEeXKf5G02dqXFSmXLv6EhwrcI/2Gy9ZejosC9EBOC35C8YeRIpyBJVVsBLgur8iXMWQFaSk5jzQyagWU4Kj5b3d3+LpQ3EcZduIGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SB4ggybQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769439442; x=1800975442;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=pV6+UeigcM+FGxdIo+s+rhMmnmFEIsga5wQGALUEZ0o=;
  b=SB4ggybQUUPK0A3d9dhrTnHIG//4NaYHIJ6ZCFpoIYYe2fHkgwgVUIz9
   44DZuMtAw8sP5s8w6AQIWY+ykZl91zFP2v+B+Hen+Sf8G6n7wA7WDUK8f
   w9rTUOBj6pELSDjNC0kz9S0Jm1AWxfgWTkgo8/0U2Pa+evizq247WKYBL
   SUMP/T+L80gwU+rIF3IKVuTqDU/B/zYxVi4vPBze9Sz0iV9HjvO5sNuM4
   vrDuc/X9wVtO5g4hERZQxmDBOjdpLSuJ+cYavMcH64NegCQUxn5KEawFY
   pQqcwHlgRmMgLkv7Bmihqz5AUvkv7TVTn0/Cu1TJQfug0te8s9DXsLJo7
   g==;
X-CSE-ConnectionGUID: /I40s6LmT42YNbqROoqZfQ==
X-CSE-MsgGUID: 7JDAmYmSSIqkPlHx1I622Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80916134"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="80916134"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:57:22 -0800
X-CSE-ConnectionGUID: I618nxkCQUG4ZXsJOqT5Ug==
X-CSE-MsgGUID: CWWxrZjYQc61wLxu/E+6jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="238373084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.150])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:57:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: rafael@kernel.org, dmitry.torokhov@gmail.com, Shyam-sundar.S-k@amd.com, 
 hansg@kernel.org, perex@perex.cz, tiwai@suse.com, 
 gongqi <550230171hxy@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260122155501.376199-1-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
Subject: Re: [PATCH v2 0/4] Add quirks for MECHREVO Wujie 15X Pro laptop
Message-Id: <176943943168.16098.2313316993180631363.b4-ty@linux.intel.com>
Date: Mon, 26 Jan 2026 16:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20624-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,amd.com,perex.cz,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E643A89E29
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 23:54:57 +0800, gongqi wrote:

> This series adds several quirks for the MECHREVO Wujie 15X Pro
> (AMD Ryzen AI 9 H 365) laptop to fix issues with the keyboard,
> touchpad, power management, and headset microphone.
> 
> The laptop requires:
> - ACPI IRQ override for the keyboard.
> - i8042 quirks for keyboard/touchpad stability.
> - AMD PMC quirk to fix spurious IRQs during suspend.
> - Conexant codec quirk for the headset microphone.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
      (no commit info)
[2/4] Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
      (no commit info)
[3/4] platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
      commit: 2b4e00d8e70ca8736fda82447be6a4e323c6d1f5
[4/4] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
      (no commit info)

--
 i.


