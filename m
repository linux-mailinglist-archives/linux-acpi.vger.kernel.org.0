Return-Path: <linux-acpi+bounces-9576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86AA9C846E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 09:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0A282D2F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E1E8857;
	Thu, 14 Nov 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkFJJccN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3022611;
	Thu, 14 Nov 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571223; cv=none; b=ka9CBJZFLLI+3uTYsqU3lf2l9mYUmpFLVREqYnFp76uYyMjai2kWLMUNu+x1ipgjzaNPVqeqPcZI47p7a+91rafp36D2vSdHlD3IA/1YzNmYk+gWx3qkN7VbZOAPj1nC61n/0SdUO4t6clJ/tqI6dE9cCovJDM9XTm7hh4cAcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571223; c=relaxed/simple;
	bh=pyJ67CP7rBFGXzeAdWnMM/ARk3xiWgaToDtifWrU47g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIVOFrVs43G0KFnwTq8TMuk8Zdhw41Cqn9jI9gpo9nelf+E0qsj4W/J2nMwhpQ1vCSdnyhIl9Fj9QwgudU9K6w4a67632IU64hWIExZGBWLAvY6+bGAabHkPFkEB9yHs5Jz0UPQ34UzSpIBm47Vab+JI0hdEfkGHJLxvsC1p0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkFJJccN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571221; x=1763107221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pyJ67CP7rBFGXzeAdWnMM/ARk3xiWgaToDtifWrU47g=;
  b=gkFJJccNtgSApemopr3RtZk2cD5GZ9VxdwlrGfvFo6bNetgQHelA3j7S
   AcHU/Be0i3BUS8t8x2TfjZ9CF5HO4opCm2wO5Fq7iwYJqOZYBWqxIxjCf
   fbFzNTFzWDg0uUcG0jhqbkW8gXzrqdBbnG9xp0PYhaUkdBQ/gfr+lwC6b
   aIOY8RebDHU2Nm9BxFk6JbqqNczlD5LeodfljoQ02InbDLRTrLeDd6CIh
   KTQyXmCey2KfSLy51Ilig8KBnpU/q/g+uCWIz77EGg5IlEkGD0BvGQpaJ
   lHYm53989OznRL4z5AlC30oVGOkkgaPgtWCIY3ooTC9ZWcaBY6HJu+ggB
   Q==;
X-CSE-ConnectionGUID: fhWmVSX5RCWNDvBdgl539Q==
X-CSE-MsgGUID: vEk5OvQgRCeg5n9MPUJk+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35290887"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="35290887"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:00:21 -0800
X-CSE-ConnectionGUID: QJPrDpFbTgCDzVauE6MRxw==
X-CSE-MsgGUID: yxtGgvJWT1G9Sp4fPGsyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="118942327"
Received: from unknown (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Nov 2024 00:00:20 -0800
Message-ID: <bec1b482-66f8-480d-bb01-31697c5e953f@linux.intel.com>
Date: Thu, 14 Nov 2024 10:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
 <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
 <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/14/24 6:33 AM, Shyam Sundar S K wrote:
> Jarkko, will you be able to pick 1/5 and 5/5 without a separate series
> or do you want me to send one?
> 
I let Alexandre answer to that since he's the I3C subsystem maintainer. 
Some maintainers prefer a new set and others may pick individual patches.

I'll give anyway my reviewed by tags to those two patches.

