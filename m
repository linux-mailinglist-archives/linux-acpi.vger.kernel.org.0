Return-Path: <linux-acpi+bounces-20502-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLzxKNvacWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20502-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:07:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705062D8B
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 149CD3EADC6
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2E361668;
	Thu, 22 Jan 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO835geD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9E329E53;
	Thu, 22 Jan 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068738; cv=none; b=C+Yi+vZne60OFI/0Q0/K1ifZre6vDEZ7/YhSccOjWJqrEDRzgqAtMxRyaWg7+1VprKq9RtyeQG+ZECvwo/m2KNUndxhf75Z6UXdjckaqIp/Rc7SJ4fwI/kxO1FnREqJNYcOIVbeEGsa4m+QGwchihPk2EoEWLcB0F5IB/alc/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068738; c=relaxed/simple;
	bh=7+vsgUSihk/yhbID350DXscn0/De5XxWPMepOpJ2ZwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+KBtRqrVCNlFF/sUIhIQiBjmsEW3eH0VdlQR1f4QrAhzu0iILe5hnoqat+yOF42BHl1OOYfExLnJtD0CE1K7R9fQ3mP6SpYLvD/G9GewYAtCHhnQLPAibhdCpOcsi1PR6Y5kDRxng9bmk8qjdKPOobLnoU0WUUaFiFm7d69494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO835geD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769068736; x=1800604736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7+vsgUSihk/yhbID350DXscn0/De5XxWPMepOpJ2ZwU=;
  b=DO835geD4SN9lgD8HfsUAAuYmoOLaLlloE0vMTtYpCUQShCNxX/i5rFa
   U/xWf4giT0hA5T/GzJmTSHyhze3YsEIZp2OyaMs9AVp7Bl81hTU9OJ5lB
   /jHJa/1ZOIzvSnwYAHoCfwPneabL+BCfpCs7z447/qYtqG1pqlGCvntSs
   QJr6O77fPGgmKM0wtA4eThLbkFe59ZHEBQOReZ2OauLwv3AKFblDBABh0
   d1ICuw/Scqwr0t3m3C+a2WG+uHGs/qkHOU8WEje0LuO7C3ROeLaQ68sfq
   iGiHM35rJq22kTDVj4Wv4AJJwJbJ3puMFws3fxCv42UbyShwqmY2pxP6w
   Q==;
X-CSE-ConnectionGUID: q9culMttScSoFvvtyL8DpA==
X-CSE-MsgGUID: PiV1knWqRxG0KDMaGDtv/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81415976"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81415976"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:58:55 -0800
X-CSE-ConnectionGUID: 7tPKBUo3TXWphkzQQGm0jQ==
X-CSE-MsgGUID: 1hMEMq5LTgm1f2aU06o68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206713793"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:58:53 -0800
Date: Thu, 22 Jan 2026 09:58:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/1] ACPI: PCI: simplify code with
 acpi_get_local_u64_address()
Message-ID: <aXHYuwPiC1KAceZm@smile.fi.intel.com>
References: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>
 <20260121231520.GA1221379@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121231520.GA1221379@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-20502-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5705062D8B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:15:20PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 21, 2026 at 09:50:49AM +0100, Andy Shevchenko wrote:
> > Now we have a helper so there's no need to open-code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you!

> Looks like most drivers/acpi commits capitalize the subject line,
> e.g., s/simplify/Simplify/

Unless Rafael wants this to be done I would leave it for now as is,
but I will try to remember this for the future contributions, thanks!

-- 
With Best Regards,
Andy Shevchenko



