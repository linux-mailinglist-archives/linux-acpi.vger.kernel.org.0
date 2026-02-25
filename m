Return-Path: <linux-acpi+bounces-21148-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPcUBAjLnmm0XQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21148-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:12:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAF1958F5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55279311CC48
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2E38F950;
	Wed, 25 Feb 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpitM1Sn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A438F22D;
	Wed, 25 Feb 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014088; cv=none; b=GZJWz50PzJNiPHxcKArFGW2bcMZgNRUUK3MESvEeJy41fZmcMHtHj8f+p2QFSen7PpHX7ychT/0G8P7qwlmNk211VaYYeJUCqRPGUuY28Yb23u2ro8wuwnxIdvKeAs1c8ps7Xg8as+3xs4tAemo/aeRo7ug2vBXA2U40askj1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014088; c=relaxed/simple;
	bh=NhNADHZtrkaH6ZBxLSszfkkgrCDJiaNEMQSTgfzNx/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIMvCISGc/HeLMZBFOaHtIawtcWzxA6mBhvsPUCMH8P/peoW3LZvMcr+0rvFnajr1FaEWegyTilP9G7YPZtC0yqZ4M0kMxNDO+J3L0XuKnjCG9lwx0nK24EcTKFSa1oKzWO1hMgvSj/A78n5JMVs+tcHKmTlkuKZ7BLmI+t/W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpitM1Sn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772014088; x=1803550088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhNADHZtrkaH6ZBxLSszfkkgrCDJiaNEMQSTgfzNx/A=;
  b=TpitM1SnteUohGAdtGJzMOnsyCAIcQzNtHflhhuXUU3wdM6zKsDIXrQO
   w3ykXL0nDk3t5Zu2et0SSsjFB2qGyodnBSFvMS/MgXm3pC1TXyScaO5C2
   3DePIx9fWy46bwyy00p6ZvUMCQhLZkEJ/TGBcJKZOl1ZzGgfhbLn/ewQM
   ECA7JuwkcZmYUlOKMcXQEIRLG3ZB7ciZh3hSo1m1AutgvdgpFTZtou4dA
   OrB/bXRvGtbQmhqKNb/FETgqizv3oQSU98Rftw0KuGzevvV4otvDHemgK
   UfPCYwY93uV2o+L/IHyb7bpMPV8gTO/OfBqQago+VjqOzOpqWesvbEfEJ
   Q==;
X-CSE-ConnectionGUID: gSlQdf/ITF+/MoZ4wQZ/bA==
X-CSE-MsgGUID: 5KUqh6KSQpKoRQulE25Dcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83371585"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83371585"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:08:07 -0800
X-CSE-ConnectionGUID: Lpb7nOl7S3u3KJFmAU75hA==
X-CSE-MsgGUID: o1HJoIYgRfO6cGd9/qGKsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="253948929"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.223.10])
  by orviesa001.jf.intel.com with SMTP; 25 Feb 2026 02:08:01 -0800
Received: by kuha (sSMTP sendmail emulation); Wed, 25 Feb 2026 12:07:25 +0200
Date: Wed, 25 Feb 2026 12:07:25 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>, Len Brown <lenb@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZ7J3aPURDNXK6ab@kuha>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain>
 <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
 <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
 <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
 <aZ1nsPX36Y5DuDpr@kekkonen.localdomain>
 <aZ1yyxshteYU2BAg@smile.fi.intel.com>
 <aZ6nIK2AbPBHUVfq@kekkonen.localdomain>
 <aZ7DC_46vxzU3_0J@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7DC_46vxzU3_0J@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21148-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,gmail.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 65EAF1958F5
X-Rspamd-Action: no action

Hi Sakari, Andy,

> > > What I don't know is USB Type-C and USB DWC3 code where it's much more
> > > complicated. And I'm not in a position to state that the change won't
> > > affect those.
> > 
> > Any idea who has the hardware in these cases? There aren't that many users
> > of this function out there and I think at some point we do need to fix
> > this.
> 
> Ask Heikki?

I can test any fixes or changes that you guys want to propose for
this, np.

Br,

-- 
heikki

