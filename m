Return-Path: <linux-acpi+bounces-21304-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPQsMqycpmlqRwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21304-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 09:32:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4801EAD3A
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 09:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06CB93048B10
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66930499A;
	Tue,  3 Mar 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyCvDORV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91559306B0A;
	Tue,  3 Mar 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526506; cv=none; b=kp77lrbYOYvkLEcz++vFnx0Urq+xs5fz/U3JKF6uDs2BNBHZ6JiE4TLVskHB/3K4uM5bVsavW+5pUkoeOA9YbDFXp0A0EzKyXG8SpvFjoeqJAu7EY+7pgVt3FdqR5JP+sy6Th08KYAfVB61tOW+Uwffs4vRArVqMAyIQPej0vfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526506; c=relaxed/simple;
	bh=+Uvk/T8eHyhvYBgI/yaWN9WQr2K9kAFp5sVa71BCDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swIb/L2njPP2GQ86nCZ3kEqtmS6gfSj3Y80G7HnLcHc6HZPOxAazLK75bQdnaP7kCbFsgy3ndxWifm2R2WE1zr7Ez5Alvh2Apmt7dKUqc2If+UCWl8MSX+Z91+wQlsyo0r15fbnLzgOdnS56Ngk09GQA33+uXCJnsO3llpFDP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyCvDORV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772526505; x=1804062505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Uvk/T8eHyhvYBgI/yaWN9WQr2K9kAFp5sVa71BCDuM=;
  b=EyCvDORVEastF3epfYKoRxKWgE8WTbCCaAAQ/FFR6EXra4Zn31eg9+wx
   iotDz5btF65tyxJzVjHOoJNM98M+Eov+QVpqZw1RLmtvlKWlvTpCCQFiC
   Osd6oXdMk6wWC/FgZE2Cmo+VE3jDgu4gEl0MYsMks9qdwoJ7iufB/Z6ce
   rGs+1dxajzSWVtR5Toa4bsqXbpgudStdXgi6uu8EAu209Br9GymOzz7Jz
   vqaTmRN4D2LqhLs2OL/bUadjv6lUYiZnfHbnBEKj2ueWCxcGzR2TUW5ZV
   w8k1eg+0tn8XyRa8VZaewgck/JwqjMzN+audZk7j7A3qI0S0dcl4DC+ft
   w==;
X-CSE-ConnectionGUID: 4UNS501RRY2VAKWzG27HrQ==
X-CSE-MsgGUID: RDk36EabSZSGzrEy0uSBnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="85020607"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="85020607"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:28:25 -0800
X-CSE-ConnectionGUID: KluLWmHOT1qbNYV8P5/urg==
X-CSE-MsgGUID: Ys6KuLZHRGuCtTP+VBcPzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222589516"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:28:22 -0800
Date: Tue, 3 Mar 2026 10:28:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sofware node: Only the managing device can unreference
 managed software node
Message-ID: <aaabo5LqR3Ors5er@ashevche-desk.local>
References: <20260303052146.1166717-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303052146.1166717-1-mike.isely@cobaltdigital.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 3A4801EAD3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,pobox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21304-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:21:41PM -0600, mike.isely@cobaltdigital.com wrote:

Can you send it with proper version given (I think v2) and changelog?
Also in the Subject a typo should be fixed: "software node" is the correct
spelling.

-- 
With Best Regards,
Andy Shevchenko



