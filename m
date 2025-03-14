Return-Path: <linux-acpi+bounces-12247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF4A616D8
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94BB3BA6B3
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5A203719;
	Fri, 14 Mar 2025 16:55:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECD18B494;
	Fri, 14 Mar 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971310; cv=none; b=WXb+ectPopU3zikjNQ77t4ZuAa5de2ZVDUQvWjcdgaSxjCUkEl6Cb7ks0cwS74xnkQk91aQkh87r8R2ByVzESopsCynejrJArqWIKI3/DeSw8tZVTnpYZ+xQLKnjCwiF6MX6o/IngyxVg/WSMjyBC62TQfznWW69rFyEprMRhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971310; c=relaxed/simple;
	bh=eaqevo/8WPvN75TZGDjs5LPg1x4Azhhw0UeGvQTfxw8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ud5QyKexls1bSbYFle3uVVP9ad7Nk8cgmPwr/s0d7MkiTeMZ5jJmpK3aGa5ivpVpnZj7vLqzxc4D1X1pMpJVMZCY7GkD9G4ZYkrLKhmrH+0S7VVahtSqds8q9duW/Qo+Da8uylODYyyP9cTtWf8+DCTXwvBIObYOmULPThTag4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDr5257m2z6JB73;
	Sat, 15 Mar 2025 00:52:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0952A140442;
	Sat, 15 Mar 2025 00:55:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 17:55:03 +0100
Date: Fri, 14 Mar 2025 16:55:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <rafael@kernel.org>,
	<lenb@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<bfaccini@nvidia.com>, <rppt@kernel.org>, <haibo1.xu@intel.com>,
	<chenbaozi@phytium.com.cn>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <20250314165501.00000606@huawei.com>
In-Reply-To: <Z9QxUNP2aqTGpnMJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
	<Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
	<20250314101226.00003830@huawei.com>
	<Z9QxUNP2aqTGpnMJ@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Mar 2025 09:38:24 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Mar 14, 2025 at 10:12:26AM +0000, Jonathan Cameron wrote:
> > On Thu, 13 Mar 2025 11:02:37 -0400
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:  
> > > > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > > >  	start = cfmws->base_hpa;
> > > >  	end = cfmws->base_hpa + cfmws->window_size;
> > > >  
> > > > +	if (srat_disabled()) {
> > > > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +    
> > > 
> > > I thought the srat was optional regardless of the presence of a CFMWS.
> > > Is this not the case?  
> > 
> > True in theory, but do we want to support it?
> > 
> > I'd vote no unless someone is shipping such a system and can't fix it up.
> > 
> > Jonathan
> >   
> 
> Well, this is really the patch trying to deal with that I suppose. The
> code here already states its creating 1 node per CFMWS in the absense of
> srat - but this patch just changes that and says "no nodes 4 u".  I
> don't think that's what we want either.

Under this specific set of circumstances, "no nodes 4 u" is
to me a perfectly valid answer.

Jonathan


> 
> ~Gregory


