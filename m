Return-Path: <linux-acpi+bounces-12913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCEAA828CB
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F8172F16
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3296265CD3;
	Wed,  9 Apr 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMxoCxvR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329361E489;
	Wed,  9 Apr 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210010; cv=none; b=k2iLwhxmkUc6uaJ+7JVDbHi27YNjrF0/BSWDsOJk7A9eT3Twjq4qZCOdlovHN2dbnarkszUgl2a/p1rGmrkDqdTr/ISegLtvdimC9DqTMFhyIwUo0htIRVv7KbEZ55PA3IFsnBv/gsCRFiXncAkRVWDNtCKpvKxgpoDeOmTo9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210010; c=relaxed/simple;
	bh=hZ5i2Uwnm/s61cw4a8JHV9Vst+P0EI/n8809SKyHvqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShHFOlxLUIZFRVzml3oGQD59vg2ka7rJMx/tWdQYnOc5XMKIEFmDE25EkKfoDtF5XYudalpPDz9qzg0tdnUea5T8b9U44QFIeg3QWbfg/IFnBjFrmGkb52HpvuUhRb67lX+hXP77wJIWk1j1rd3zJ6V5tAsZYpmSRplQK9rw5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMxoCxvR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744210009; x=1775746009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hZ5i2Uwnm/s61cw4a8JHV9Vst+P0EI/n8809SKyHvqs=;
  b=fMxoCxvR1gEB044Ewf19wfqO6ejQOj0MU5mBY5BeNu0o0aqt7Mt25zX6
   edNUXQXZzTm337HlmVVy8y62v6Rc+dUvEC1aTQtGCGko+KIeNHwvPkT6L
   s+yHi4OcT8yA9E1Ex3bb+MecPgBxO/tVSJ72DoCo/50rk4YUSXi4DbOK0
   R6Rep0SdNAVos+z4WLM5IzfCUsbzPc2ORD1lfjNGPjn/u5/JKv9EVUvUC
   esz6r8QeomFB7lS9v+w60Iu0XbRbWdGRmKKxtfFVEhh7jmXi5voqFUesp
   aZlp/g40rX6c0DcqPhrOTH5xLNEkoRcyPxPkEoqYCfsjgKCtKcvs8zSub
   w==;
X-CSE-ConnectionGUID: FtI4+OVuQmSZAWtNGIMYXQ==
X-CSE-MsgGUID: WRTAoLJpRECL9aXZy9lJtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45576936"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45576936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:46:49 -0700
X-CSE-ConnectionGUID: j0xrEPWdSxulCWrX/Mtl7A==
X-CSE-MsgGUID: siqXL73TQEuTKFLU8sieJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133596999"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:46:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2WhO-0000000AlaQ-3RUf;
	Wed, 09 Apr 2025 17:46:42 +0300
Date: Wed, 9 Apr 2025 17:46:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z_aIUokzC0eD-Uw-@smile.fi.intel.com>
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:19:03PM +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 31, 2025 at 6:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Add a note to the fwnode.h that the header should not be used
> > directly in the leaf drivers, they all should use the higher
> > level APIs and the respective headers.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you, but you already commented on this and proposed the better wording
which is in v2. So, what should I do now?

-- 
With Best Regards,
Andy Shevchenko



