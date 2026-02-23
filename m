Return-Path: <linux-acpi+bounces-21086-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHoQJVm6nGlHKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21086-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:36:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F817CFC6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4980D3171C33
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AFD36B059;
	Mon, 23 Feb 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+64DF2B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C7369979
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878814; cv=none; b=lhzOnXmZ7VRjGlsRrhB8lHd6hFE/OgnQRf/siPicArXrJ8uoClqiUMYYTvWPsCSG54ME9H/nWFZwnOzMt/1kzix54jVBi9qa26zmD+9AM+RciLoMepdWzjFX4ub2Z6SJ2LP9FlZvHJh0vAQIN7xKHwwITz8yJsdgLJCWapLUOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878814; c=relaxed/simple;
	bh=ESvyMVF+dYACKaZd3BgG8cX6TSnmtZvG/Oqd/0HHweU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEnsz5SWDRi0E+h8oc7krzKNBsngMv7p1x92Cvte0qQXW8ZhyNMjKUXUN9VfOXS87+BLuZ9arW7kLDP3EGeY4duCbntm6gjQNGr6sfLFwKtTxWx+NgHSfVA48LC9kqcB+fGxY1h5ZDuxokoBEMY6QIJvR6BpAhX3OitVdpCfdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+64DF2B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771878813; x=1803414813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESvyMVF+dYACKaZd3BgG8cX6TSnmtZvG/Oqd/0HHweU=;
  b=a+64DF2BDyUPXsJnJtEl+zhij6Vql9MIo36VgExlSm5K8YH8dENwL1vF
   nkBZHMRGb0KtbNvQtfpOO56hHt486+uIF9xQK70Vxy4y/I7e9Mq7IcDvE
   zlWuAPh2ESJymQ3i88d5XqHwLDA9CNUDo35xd3pz+vlIdcuEnwxiv0OsH
   cpYGEWG2p9JGFvjV8y8NVKV0cwymFw+xoA83ODs6vq7jPX5t+eRh0b0HP
   CUwCIR2Q+/bzAGXeg/U5YJ28xeuYTsrt3XsMP5AQ0krbrQb/ZVxjR4mbi
   gwGeqJPfeIescXBuh/Z7TfT4lwH+sjBEoLnM0qBOA7MP2UqcktHJ1IQxv
   A==;
X-CSE-ConnectionGUID: sCP6a0eZSHaYdN/PdRHl/A==
X-CSE-MsgGUID: fm9LaExhRR+pbNw1td0dVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90467253"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="90467253"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:33:33 -0800
X-CSE-ConnectionGUID: dZSSgVerSTmU0I/oI/AvdA==
X-CSE-MsgGUID: J3Ia0JU8T9+hgS/7mDMJgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213988161"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:33:32 -0800
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: tony.luck@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	nathaniel.l.desimone@intel.com,
	rafael@kernel.org
Subject: Re: [PATCH v1] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Mon, 23 Feb 2026 12:32:58 -0800
Message-ID: <20260223203258.2877-1-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <SJ1PR11MB6083ECBFD999F240987EBDE1FC77A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083ECBFD999F240987EBDE1FC77A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21086-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathaniel.l.desimone@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: F26F817CFC6
X-Rspamd-Action: no action

> > Add sysfs attributes at /sys/firmware/acpi/fpdt/tables/FBPT and
> > /sys/firmware/acpi/fpdt/tables/S3PT that expose the raw contents of the
> > FPDT subtables. Note that /sys/firmware/acpi/tables/FPDT only provides
> > the top level table, not the subtables. Adding access to the subtables
> > enables a usage model similar to /sys/firmware/dmi/tables/DMI, allowing
> > userspace tools to interpret newer record types (e.g. String Event
> > Records, Microcontroller Boot Performance Data Records, etc.) defined
> > in recent ACPI specifications[1] without requiring kernel changes.
>
> Is the existing (for BERT) /sys/firmware/acpi/tables/data directory a more
> appropriate spot for these? Naming the new subdirectory "tables" seems
> misleading as there aren't a top-level ACPI "FBPT" or "S3PT" tables?

I'm not experienced with the organizational semantics of sysfs. I made a
best-guess when choosing /sys/firmware/acpi/fpdt/tables/FBPT. Should I do
something like /sys/firmware/acpi/tables/data/fpdt/FBPT? That way the data
source is explicit and there won't be name collisions with other data in the
future?

Wherever the kernel maintainers think is the best place to put these new sysfs
attributes I'm completely on-board with. Please let me know where in the
filesystem they should go and I'll get a v2 patch implemented!

> Once naming is resolved, needs update to Documentation/ABI/testing/sysfs-fi=
> rmware-acpi
> for whatever names are chosed for the new files.

I will happily add that as well in a v2 patch series.

>
> Code looks good.
>
> -Tony

Thank You!
-Nate

