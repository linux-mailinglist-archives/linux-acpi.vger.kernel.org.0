Return-Path: <linux-acpi+bounces-10315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A39FD59E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C003A17B8
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7401F709D;
	Fri, 27 Dec 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HQGY/UJp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD831F6695
	for <linux-acpi@vger.kernel.org>; Fri, 27 Dec 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735313762; cv=none; b=BqE1sBRI8jTgyqo6cIzt3/E8zALqEMWWFD/8rPPwNlBKiHaU2ymyjCspbqwUPjo1tXFd9Akqxge3pG8EK5Z2NMH5OvctRn0gpZrm/8AqJrZ2BDynAwT71fYZnftNkpWkPO4Fgk57yPZDkD5W3kzA4DAzRFqyEhg3P6W4xdMcuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735313762; c=relaxed/simple;
	bh=pc+3DjGV5EC4ZiB3ndumu1Ik5tJwLfzCdHLGsP8jRrI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7qzHR8JPAimdR5Lwq2P2w5x0eaFOrzNiSRORc1X79Ab2Cijj0dAB+p5+BuYvZnbBGE0FCd7qzHBTH3Slyn0V5NeoYnP+SKz3x8TWWsQG6oauwR6bg2XC1BXRydgMyrrN4IRPKkUxqkwpHU3ap0u1TMuG3mE4gC1Y7TWGC90ZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HQGY/UJp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6c3629816so356785285a.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Dec 2024 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1735313759; x=1735918559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Krzrbn6PXOKlKH88VdMhylbF4qrHa0b2o3mXIp6plMU=;
        b=HQGY/UJpRahq4n02pCWhiWfoxdTL0uWOVnCYI0DVeLRAtEsS1B4NKA4QTTIcM9Qn4e
         c9lYIJ2spGQiltEq4+wLufGdjVwh+wPhbjpLIsBuE2DdZK5FfZzJfK+SlCBRCjPWMe4L
         Xl+4gAgAzEWvstnMYH33fP7ODV++XQ1L8GcEpImjyCjQ6s7IoAUtK5EHHBmhu/tiHqWl
         u4ZV9cZV8bXxmg3IdCIBmw6V52OCQNM4BVdqbnmtBlgrE8nXyuL//QqBOu306dokY7sV
         mf0bdJj/5jcJBJ1uWb6ES2kGTp8VNTPUNpzSydLiLWqIwwAKWnXu5R5VvhaXtcQCiwhg
         Vrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735313759; x=1735918559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Krzrbn6PXOKlKH88VdMhylbF4qrHa0b2o3mXIp6plMU=;
        b=KjU9BxIlTzPCfMq6lOhkkUcts9ObVTItM84VPmpwhOnheQdc4vml781y/nqTNKzewe
         p9HYsnrKqImhv2rvIVeXbULK1ZCmILL74eX8wlYGtRnD4NCooW9EPlF7EjStteztwa6w
         0NWstUG6rFKTfVJS+JdjYxz8LvGbZZQRRgiFcizMk7w4E4+Au2GQfWuM13oeBG4qntLK
         BUtII1XmdXThHVEVC77TrkC8pwUa6CepW5iQeu5Bk++c7G/qZLk4bL9TAGSqMb9ksEsX
         e8FiEnOallyZH1+1w/c+Z4uqPElavX/B0ruI1ae+dGDWpzq2uj5cIr0JGRZDeCu4FOrw
         8E+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZTs7AWBQ951sodR2IxhdIO2c+nHYH8F5UdN2O1H6yIhra5iQvGChX8IDX8tkhhARL63LIxqoaFeDS@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkWOohkCAmTwcmUXebZ2aeX6Iw3mV583/eIsJ4aayHo5hvs6o
	43BCX6fvJ6xzCcf2h0FtxOXV7TXHjMDBtAc8xtyg50X6YbzNbWWmH3DPe05HG7g=
X-Gm-Gg: ASbGncvcfw94BrSjAcVZxZRu4vYWEM8owE6aZTnNQjsufVweJctxkxopFcY4oT8y8bn
	JaT+NQuH5Fk2H1j4kLx7esdXwd9bt8rL+bQ5ErO0pGhYDi5iwssv8uEryigzDwqMvhGxyF5w/uO
	zvZ8tij34pORDRtlzzwPtuOQpXFGaU+VJtSmonbckvQvwff/CAj3xCChLf0yJQi7Z6uR+SvD+NJ
	HuuHbZUsqa/pH3RmoP6/QzhRKCfj+bF7w11RWzQPNztGnm6JQfN5YAD3DvlSpOEAe+9sfQezNOW
	/SjEw63Otb/CWqkjRv7JLTdpEaodkCYBAISIeNKbU8/QF+tIaKQWuWM=
X-Google-Smtp-Source: AGHT+IFBiajcRqof2sDefXcLZ3WaH4m3mlxC0eaX7BM/iU+6OvZhFmWXLPQ08OqoFFdkc3vUHBeCyg==
X-Received: by 2002:a05:6214:486:b0:6d8:b594:c590 with SMTP id 6a1803df08f44-6dd23307cacmr367478586d6.6.1735313759312;
        Fri, 27 Dec 2024 07:35:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1820810dsm77246656d6.131.2024.12.27.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 07:35:58 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Fri, 27 Dec 2024 10:35:56 -0500
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	kernel_team@skhynix.com, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
	=?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
Message-ID: <Z27JXDwEmplZCDEX@gourry-fedora-PF4VCD3F>
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
 <874j2rp6or.fsf@DESKTOP-5N7EMDA>
 <Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
 <87cyhdhon1.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyhdhon1.fsf@DESKTOP-5N7EMDA>

On Fri, Dec 27, 2024 at 09:59:30AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> > This still allows 0 to be a manual "reset specific node to default"
> > mechanism for a specific node, and gives us a clean override.
> 
> The difficulty is that users don't know the default value when they
> reset a node's weight.  We don't have an interface to show them.  So, I
> suggest to disable the functionality: "reset specific node to default".
> They can still use "echo 1 > use_defaults" to reset all nodes to
> default.
>

Good point, and agree.  So lets just ditch 0.  Since that "feature"
wasn't even functional in the current code (it just reset it to 1 at
this point), it's probably safe to just ditch it.  Worst case scenario
if someone takes issues, we can just have it revert the weight to 1.

~Gregory

