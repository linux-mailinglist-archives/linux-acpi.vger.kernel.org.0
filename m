Return-Path: <linux-acpi+bounces-9636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8B9D1342
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 15:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17671F234D2
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31181A9B34;
	Mon, 18 Nov 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9mLaTzW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328101991A5;
	Mon, 18 Nov 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940521; cv=none; b=jXqAGCaLvX8niN25y9sDBgHXlPVFbqUCOOYtMfavxoYk19mvUGR9jyeTNUH8xCbqT3Pda2RAP625AIttD1xj5Vwa/uz97FlKGFPsFmNYw6swgnVrPX0FwU9u7ySoprHLdKrb8J10xeT9Qe4XB7ihHurh5oDqP6C5PqKnNMMvCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940521; c=relaxed/simple;
	bh=c8a+EImhGlsWDHwDN19J6QvrBe0SXGlxQbSqYKwdzdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swh1MK00UIflW31B4lJv9PUmVKO2zRxRzpGPKP/KcjXHqq0Zj6+n8TQP3q/sxq0/W3CVTVYFjOiK2/ufTLkm22u8r4++Pcjj6BXuxsksbfUdpDnHMPvzDaDDVH40BshlXvrDKbFk23zPisal2A999W1AlScnlAYYrRpEV3lrSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9mLaTzW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731940520; x=1763476520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c8a+EImhGlsWDHwDN19J6QvrBe0SXGlxQbSqYKwdzdE=;
  b=b9mLaTzWaAQJwzLDU/JL2petQCjyu4SWs/w/baMrMHxNoh3gBepWQXRp
   9+gtS8mX9T6zVJZ5g/GmuMbKYJ8n01gJHBZfVZmgi9crYd00lnhQZCtUx
   8Lq5Sf3WBWGjLKbTqbm2+0a7UPiaQjGU970jEFWODsJzXKxQ2PzEzRno6
   +EuupMNj0Douj/nQCjNllxEPgc+lPKZxo4Scusg0Uwqr/7OZndlHhG1xa
   gPpwtX5xQsAQOzx+tiIwTvvhBJa9tI5BYrRQt8aXaCCLNTChA1KIe7nAI
   VGhynl88fD4Q8LsOJiYskxihgXgu+b99zY8xdss6FgK3UPH+cFPDuvTrF
   A==;
X-CSE-ConnectionGUID: BV0LLOU+SOGNT5bFFuRjwg==
X-CSE-MsgGUID: NPIO2tIfSLiFvYfWNJrjDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31824991"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31824991"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:35:19 -0800
X-CSE-ConnectionGUID: dAbOixpGSTClvAWHjuW4gg==
X-CSE-MsgGUID: 661glKQvSUmZnsGFwwCrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="126780482"
Received: from rwthomp1-mobl.amr.corp.intel.com (HELO [10.125.50.190]) ([10.125.50.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:35:19 -0800
Message-ID: <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com>
Date: Mon, 18 Nov 2024 06:35:17 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, peterz@infradead.org,
 frederic@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> And the argument seems to be that it is better to always use more
> resources in a given path (ACPI sleep in this particular case) than to
> be somewhat inaccurate which is visible in some cases.
> 
> This would mean that hrtimers should always be used everywhere, but they aren't.

more or less rule of thumb is that regular timers are optimized for not firing case
(e.g. timeouts that get deleted when the actual event happens) while hrtimers
are optimized for the case where the timer is expected to fire.

(I'm with you on the slack argument, some amount of slack, even if it is only a usec or two,
is very helpful)

