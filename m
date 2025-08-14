Return-Path: <linux-acpi+bounces-15714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4CB272CD
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FA1627301
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C97D2877D7;
	Thu, 14 Aug 2025 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW1MsRk4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9928751A;
	Thu, 14 Aug 2025 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212980; cv=none; b=UzkAGCwTHLlm+vJXvVhGvSt8umjrUyVp9tZzIVBsfhF8FKtalcdn8Z1fbmFtjjC2jLd6StnksyQwThtAqtPdH4pdusodqM/PTRESxrFXb0Bd8mJzWyhC2VDOWccgAppCyREjCGZ1ncKOYqFo+56xjA05/wmSrDlqFhwgjDRXhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212980; c=relaxed/simple;
	bh=aokRSJi83wn6MuP5avdXHnJYDdO8hONUlIGhy+Jz2lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBg7SyhIGgOIZNfT5PjClnXG2efRpgomJQJEFWLOnRNh8fS7VqkMmSUIZD9g5NvzMf6iSazr+dBcqagwvQjm2r2Cf6zi98OtX2x3iEYI2+KYxFs0kzFC2e8gd/G9b0qFXWfAkulAZXLE6IhFO2zT9bO6Rqg8ctW4yhbG4ux8n6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW1MsRk4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212979; x=1786748979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aokRSJi83wn6MuP5avdXHnJYDdO8hONUlIGhy+Jz2lk=;
  b=aW1MsRk4pZeDd3wKWGmHJi9Z3wpPY0FH7uUvJYydyxyUwQCrw11t4sVf
   oK14fTr0rYrA4mJ/iPGFXBpDSHXbLvvOd51JvTWUtPIiZNAvip8lX/hOA
   QHYtQPmCd+cXwocalm5B/FYX4As2YY7kWub/boIEOgDn2llnvjQU6OfC2
   xx5uu4MSDBcN9PtRV6rK2R7hMcGHjkIARaDuy3oEgReAbpPD2N3vyogWW
   rzhcVP4tzJ2+ykJqfv8YuRD3sw2xgKQKeDOJTgddNdf91obijwTfZi+6Y
   fgZK2XJi1gH2s8fkDkPyu5oga7v2mRP5rIraEI3N9PtqFJEUlP8AANh7v
   Q==;
X-CSE-ConnectionGUID: XIU1dhJFSYaaKwhmB/Q56A==
X-CSE-MsgGUID: ODAebk55Q5mxX/hPMKAxEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56564066"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56564066"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:38 -0700
X-CSE-ConnectionGUID: 9pYHM7jBSvm2T8aKsJe9fA==
X-CSE-MsgGUID: zRPrrsF/S/yTZaTPfcsl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197870279"
Received: from c02x38vbjhd2mac.jf.intel.com (HELO [10.54.75.17]) ([10.54.75.17])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:38 -0700
Message-ID: <3d0945ca-eb6b-430d-a6d2-a4396596170c@linux.intel.com>
Date: Thu, 14 Aug 2025 16:09:29 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl, acpi/hmat: Update CXL access coordinates
 directly instead of through HMAT
Content-Language: en-GB
To: dan.j.williams@intel.com, Dave Jiang <dave.jiang@intel.com>,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, akpm@linux-foundation.org,
 david@redhat.com
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-4-dave.jiang@intel.com>
 <689e64229859f_50ce10082@dwillia2-xfh.jf.intel.com.notmuch>
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <689e64229859f_50ce10082@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-14 15:33, dan.j.williams@intel.com wrote:

>> Fixes: debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated by SRAT")
> 
> Why that one and not?
> 
> 067353a46d8c cxl/region: Add memory hotplug notifier for cxl region
> 
> It is the ext_updated machinery that is the main problem that messes up
> sysfs, right?
> 

For sure 067353a46d8c is where my git bisect unambiguously landed.

Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
(the series as a whole)


