Return-Path: <linux-acpi+bounces-2541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB858818B68
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43929286ED5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA251CA8D;
	Tue, 19 Dec 2023 15:40:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B620DC2;
	Tue, 19 Dec 2023 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Svgnz4NwGz6K9JX;
	Tue, 19 Dec 2023 23:38:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 60DA0140F83;
	Tue, 19 Dec 2023 23:40:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 15:39:56 +0000
Date: Tue, 19 Dec 2023 15:39:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
Message-ID: <20231219153955.0000473d@Huawei.com>
In-Reply-To: <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
	<20231213223702.543419-3-Benjamin.Cheatham@amd.com>
	<6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 15:59:12 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Ben Cheatham wrote:
> > The CXL core module should be able to load regardless of whether the
> > EINJ module initializes correctly. Instead of porting the EINJ module to
> > a library module, add a wrapper __init function around einj_init() to  
> 
> Small quibble with this wording... the larger EINJ module refactoring
> would be separating module_init() from EINJ probe(). As is this simple
> introduction of an einit_init() wrapper *is* refactoring this module to
> be used as a module dependency.
> 
> > pin the EINJ module even if it does not initialize correctly. This
> > should be fine since the EINJ module is only ever unloaded manually.
> > 
> > One note: since the CXL core will be calling into the EINJ module
> > directly, even though it may not have initialized, all CXL helper
> > functions *have* to check if the EINJ module is initialized before
> > doing any work.  
> 
> Another small quibble here, perhaps s/may not have initialized/may not
> have successfully initialized/? Because initialization will have
> definitely completed one way or the other, but callers need to abort if
> it completed in error.
> 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Did Jonathan really get in and review this new patch in the series
> before me? If yes, apologies I missed it, if no I think it is best
> practice to not carry forward series Reviewed-by's if new patches appear
> in the series between revisions.

I'm not keen on the solution as it's esoteric and to me seems fragile.
I've looked at discussion on v7 and can see why you ended up with this
but I'd have preferred to see the 'violent' approach :)

I don't mind if there is consensus on this, but not reviewed by from
me for this one.

> 
> 
> > Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
> 
> With above fixups, feel free to add:
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


