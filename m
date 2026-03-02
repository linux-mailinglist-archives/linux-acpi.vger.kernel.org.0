Return-Path: <linux-acpi+bounces-21295-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEDTItRypWlsBQYAu9opvQ
	(envelope-from <linux-acpi+bounces-21295-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 12:21:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD651D760D
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C261D3006148
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2026 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56971361DA9;
	Mon,  2 Mar 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rckh1YIX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA2360751;
	Mon,  2 Mar 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450513; cv=none; b=vA9QnBprP8tvak6Ldg61/dutDM7Xyl3TeSpugQ2CqH0msWZXaGwpNG8lxkS38NUVGdJAqE0aHFmgJtalyWU7BiudY+T9nHivxl/BEajRfZFfG/0AhgbO9v3/VnjctRVUdTe3q9MNoLb9uSQku3h1eByZg3XJvyQmaolQ/S93iCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450513; c=relaxed/simple;
	bh=iFbvh8tKvkPrHovLN/ghzsebmiJAP5hbMNeaXZFFXZM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DDEmI4/tAmFFpheU2f8T076sDBAOCIN0EgqCCZcppASELmqiP3VoApjf5/10n0L1VSu5je5Pa/LAWEYarsulXYbWZsvY0JcvLebfWH/kB9zrgqcwUIOvUaNBdRneXOKlEWcNyYrSa5SaDah9KWBky7U3z82ZVshAc3BMpfmyGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rckh1YIX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772450512; x=1803986512;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iFbvh8tKvkPrHovLN/ghzsebmiJAP5hbMNeaXZFFXZM=;
  b=Rckh1YIXE8w8ENqJIKV0jH1Zc3cJ56t5qpONd/7/PN9TtQIr3jrcTgG5
   Sc4tKPl8ZW4hQpEqW/ssK970Xhe4P9xweafzG5caDGy4fREtQgb9yOq1l
   8kZmEst93/UOOM5OKuW5Di1JFizv2Xu7BgiYPR02CML0oO9SbB/YDdRhu
   5OZsIYvt/CylxRNF28p8muYERd/sLCJVBr/SoH/rgX+NXQTmOlcFkAzyI
   Xi6GijmBw0co7hyPDuB/k1ZFBY8aG7otbFQ3VZYFieejVbOLGpiadPCBI
   exLjElFB8kWE+LbQMdvI2FdEB4r9YAQwFjvTsUDMGknSYeNzcIfvtT094
   g==;
X-CSE-ConnectionGUID: t9d/Bk0/QNGB9rqLpSfkbg==
X-CSE-MsgGUID: wWa+e6f8Qdqpb5yUnXON6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77318135"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="77318135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 03:21:51 -0800
X-CSE-ConnectionGUID: V99rOaplRqOEwKBSjrKEkQ==
X-CSE-MsgGUID: 2deyfAciTpuAJb7xgG1hJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="215275602"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 03:21:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Mar 2026 13:21:45 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, 
    =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver
 to a platform one
In-Reply-To: <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
Message-ID: <ab094189-b333-895a-7238-f20050966d37@linux.intel.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki> <2402539.ElGaqSPkdT@rafael.j.wysocki> <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1444050466-1772450505=:1094"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21295-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: DBD651D760D
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1444050466-1772450505=:1094
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Feb 2026, Denis Benato wrote:
> On 2/28/26 16:11, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the Asus laptop ACPI driver to a platform
> > one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
>
> Alright I will take a look if asus-linux software is affected and act acc=
ordingly.
> How much time do I have?

Please take your time, we don't need to rush things, especially=20
refactoring when there are open questions to answer.

> Thanks.=C2=A0
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>

--=20
 i.

--8323328-1444050466-1772450505=:1094--

