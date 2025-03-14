Return-Path: <linux-acpi+bounces-12244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCFA612DD
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9B1B634B4
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E201FFC5A;
	Fri, 14 Mar 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p6nGZVBm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BF1FF7D1
	for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959510; cv=none; b=MRIL9kD9peUiSaNr89E8InW0yjmoYM4Dym85SiLV7L/mQsUR4YA4/gijlQFWw8G9yDlDXGdhK2VnFQWdMPZngv+fz/VYEUjed60cpBYcjXivqKVVxkx7FBfz56YV+lX0Nf3gSQ9lHO9Sez0mm79XNSf+RngUzSZ0C4GuHiHJs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959510; c=relaxed/simple;
	bh=dTUfZaUXUhKnc6MxStAvrcDIpBExFEEzoAT/Dkc+VrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7yTqqhNJ/ffsgsvPn3EFx4O58zRwlJWfEsReySuYh1pI27rO1TB5UpCSUg8hbOspsM2HMvlcgSqAPoewISzenJhkd9mRcy5bRME1JN7pH2GGz/AJwRKW6Q3D7Ar2YBmsZ96cvjmMy0V4hSop7QVixW4DzUtVkZPdvp39Z2lLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p6nGZVBm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4767e969b94so33607171cf.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2025 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741959507; x=1742564307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=p6nGZVBmO0bijMurW7dBY9nfCMRPL1ayrrJ6qXySYAajiquWdM0P+oyYQCsXCR7jKj
         A7Od7FpV+Ql9MH9vpEF1V59M+7FmZF7gWY0cgBRTT0Z3lkgmNalaQGa5PLVhnBltilDl
         YQPPY+aLw12p5VxVfp0UtRWrc46Rf3tX/0SuzaHwwESYFpFrfGut37bR1WbV6nFnPIf8
         xVKWJK8BFL9eqLzTVq2N8+qTspB8hh7hIV59kcli9W/st9MLnRfQgXB3pp1TJvlW4qCB
         UMGSpSi2pfK5McPCzbg/APXYaycmxrr97AbTEAc5MXLCcCiLbFtVJPUleydn97Mt6EuP
         hOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959507; x=1742564307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=LDoyKUB7P6Vih1gW5Wz3TalAFjICcveIgDt/c3GAJzA0q4dYDPOF+Z8WDVv1WfvI//
         OywV3TR97SLqGiSioSM0ddJEYwYANBWpkKZGyRZTuENtb2JbeEzM8zv8PnUlOl9t6M0O
         OpAYQ7L+LKG1+ObiBN/D3+M46CpJEwq9EWM82NIQgpav0Tx8pKiZuvrEA4GNbNCfe2Nj
         mMXB3uiabAM3BWRq/emoDU3yr9bk7sEt+HzA67nBRPCHz/Uwn0M7qQ7aMQjD0ZoblOSA
         o0qC+ezO3W5ie3hAoUnhshbx2D8FTtM5/bGWyU7wM/q6VImWtJJCmFGG11JOqKRyg3zp
         ui3A==
X-Forwarded-Encrypted: i=1; AJvYcCXOfDzXRqhy5DCkU9LrXkEPx0z7nnCCcrCNLXKxYDvZyJE4UJGfAwFFManT0kCL2IHo0TYPv+FltaKg@vger.kernel.org
X-Gm-Message-State: AOJu0YzgD//rtqpUiTuQ2FXDxmGGiOTXpL+9+/EbyloBKu5D1HbuUQMh
	7dtAemgF70cjj4KwKs4SpNvup+sb4BvpFjmxmebCBUF08KAI5kVZsNYJguqr/PI=
X-Gm-Gg: ASbGncsHcgmnPVoueZMiGmOKqYq466iUkMBq7winzkaQcgohG4vGRQ0FhjcZ4ME9ZHi
	OGyTEngfEuZBebmz879EMKCB3Y4qYzqDQxfdPQrUTSHtukYjOTkTxH4ShFx+v9dwToqgFQgwpfE
	XXCmpGLihICGHpg6Te16d/dGGvGHZ7z22Yk325MGmWKrmeVCeOYNi9rs0S+pF/zcNpOcAPa9o4s
	wAkinglOdVYtSFkYYmV9MsMvcb9431xCsYlU4mF4tZhDRyFF0utf68WhQaR9B5MUH9tH5STTHbM
	UotJ9rMe1V76r0PrLSHMsHvHWO7gnsAFLzM7TYXe572u7v0/74tZXnarChwXl1NhtKMLrMeZCvv
	zmaU3W9Lq098Q4B6Ih5UKMrToq1M=
X-Google-Smtp-Source: AGHT+IEgUXDqQalq0QLNm6R9nYlOpQxNyi5UlXIxkWp5LsR9Xb92fZqa2be466apd51bhbUPRrp8/A==
X-Received: by 2002:a05:6214:b64:b0:6ea:d69c:a247 with SMTP id 6a1803df08f44-6eaea9e88a0mr39382126d6.4.1741959506662;
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade349801sm23632916d6.94.2025.03.14.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:38:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rafael@kernel.org,
	lenb@kernel.org, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9QxUNP2aqTGpnMJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
 <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
 <20250314101226.00003830@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314101226.00003830@huawei.com>

On Fri, Mar 14, 2025 at 10:12:26AM +0000, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 11:02:37 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> > > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  	start = cfmws->base_hpa;
> > >  	end = cfmws->base_hpa + cfmws->window_size;
> > >  
> > > +	if (srat_disabled()) {
> > > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +  
> > 
> > I thought the srat was optional regardless of the presence of a CFMWS.
> > Is this not the case?
> 
> True in theory, but do we want to support it?
> 
> I'd vote no unless someone is shipping such a system and can't fix it up.
> 
> Jonathan
> 

Well, this is really the patch trying to deal with that I suppose. The
code here already states its creating 1 node per CFMWS in the absense of
srat - but this patch just changes that and says "no nodes 4 u".  I
don't think that's what we want either.

~Gregory

