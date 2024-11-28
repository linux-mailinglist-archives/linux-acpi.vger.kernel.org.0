Return-Path: <linux-acpi+bounces-9795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15349DBDE1
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2024 00:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1BCB21F2D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B51C57AD;
	Thu, 28 Nov 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7m9hscT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27408157A67;
	Thu, 28 Nov 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732835769; cv=none; b=nTCcNvnrb7DtALIyQ8tvBQPyN6d7qgsSUzaQg1PT+lb+nFPRdr8EhLQ1gva+IrwOuNgkYJZSzv0V2v7D4sv2lLQd8h4gk211PBqXzDilMsxdA5HRADrltnJe80MGG5NqrjxTEyStdlFrWvqfAvR8tv1CkcIuMvMMSinzOczEscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732835769; c=relaxed/simple;
	bh=DC3MRS4obiq9akDBXw/+rZUOFRaPaxg02JSBq4jldGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWumR1+hWy8ZMY9yAFh5VD+jdExaJ9KaVLZjkM3pLAYnD7DrC/8WA05LFHsLuCZZ+JgkpGbe3eajzOhQzUOaKyQytYyHDfnLYJWY1iX6JMM/usOCkzDs8fKyOiDKt1/d40IJwWDBzU77Rqno6E5xswittwrNC1K42PikPbTekqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7m9hscT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f383c5bfso1018936b3a.1;
        Thu, 28 Nov 2024 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732835767; x=1733440567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeoVHhClbRHMNEOjFXigSnIp+fG4ZCi/q2qwDZwIfdU=;
        b=m7m9hscTpgeAA0Ca1yoMk5VJBTHkELXecc/ue7kTkG3uqqTc4nPpRjFNgDb4TWg0Dv
         pbZeOi8iAGf7LR7e0vhPtFx7xER4Wg0awo+2QTRHyOb8zfgRTa0z8YkSYZgzBWx1pIWY
         64wDXnhDJwS/LhRsziVIJI9TxRB85oJVhipWCtjwWsLOeYissz3R6XN281zk9ORBhOKi
         69mBH7xPfSJlmTMOgYJwPlAYdtYkQSuNiFaWIGk6PAEUf9bUEkGK45+Ij+bRJg8edl/U
         mgodo6oc01X5QUAzLvZDYrz0SBCDMbTv2gYU+xVMY3PSVnYCyV17w6/Dvd51fgfPPPJG
         TMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732835767; x=1733440567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeoVHhClbRHMNEOjFXigSnIp+fG4ZCi/q2qwDZwIfdU=;
        b=O7emJLZ0GS2Fx+Xx2WIYkMpt2/HVOM3KR43CU7+Yhp6E25DO6wo3DmsAEuJUudtlfQ
         y8daT/WQ+SRoE7ZT7vZleJcrC2ZumkXaAOpradA1Pxo1Na2TijwFES7aTyImSbNsW0/T
         N3I0KYaeienwLZJh6MEeuevtO0MuWnD6hLPJ4ko62w56X8U7Xo7qnnc7BOZrmuDHJ0Ft
         dSIdlrRzUJluOBS+3SyYWAR01VS2BcluolE4e8z2DMoPqfw2GPUDn56mk8ZuFL2P1yWI
         rJO7aWoFxvgIDdM1qqc+mNWiIIoClgkRfVy4C3pd36ZAnF0itZqC99ts7gCYmkyP5Hdw
         x+QA==
X-Forwarded-Encrypted: i=1; AJvYcCUukp4gFE+G9G9cFDhxnRywr4SSNxdyu75m9TY6cCAkSULvAW37++WTr2KvwzJw0vzfNR8safPp1GfW@vger.kernel.org, AJvYcCVat555CM5gvgaq/m0GXqmG6yYnPcUIhy/WADq37iYGMCn5Rzd8R1snCt8SBM62MMeePts6aN+gcm3rRKpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zsXxqbmcwHGDZIqssYk1E9yDJT+o5uYZOw4xeK9iEsfAyk/C
	3ruTBLa98p9end3ZVpSsjCuVYzCcDBSZ4OfWPz4xgLqZWXyYC/SG
X-Gm-Gg: ASbGnctiEP8qwBc525wlOjBqM3Xc0BaWHTBdO/3Je4Xj+EICHuvrSNydJyBOTdWmOQE
	3AjcxETEj1Ro2yYUVElcgAuTRdywch4xi9uPbPk/toscwpseWjBTGkic8OCOWvP8gb0Cr/03opq
	1n/2+Kyn0dkZXHza/ifOQ7f2T7fuqIzoD+8MEFLQPtmRK4Hlx3Z5h6sIV3/k7WICUv88HBN0UbA
	tbSmCVESinx9TVobZD/C/IegEU4Rs9hVukk42w1tMVHXTVMFw==
X-Google-Smtp-Source: AGHT+IGP7i1wkE6RXGcp1WsztRZKiZigxuAV4HWiC3crop7SkPxPXAbFlRQNSzk1+A6RQV8L30sT9A==
X-Received: by 2002:a17:90b:3ec9:b0:2ea:8565:65bc with SMTP id 98e67ed59e1d1-2ee097c59f0mr11320529a91.23.1732835767263;
        Thu, 28 Nov 2024 15:16:07 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:bb0d:3829:251:d17e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f455fsm18965175ad.29.2024.11.28.15.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:16:06 -0800 (PST)
Date: Thu, 28 Nov 2024 15:16:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: fix UAF in
 device_get_next_child_node()
Message-ID: <Z0j5tGF9ikgVR_0w@google.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <20241128053937.4076797-2-dmitry.torokhov@gmail.com>
 <Z0huCS4Z7dkgpCQ8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0huCS4Z7dkgpCQ8@smile.fi.intel.com>

On Thu, Nov 28, 2024 at 03:20:09PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 27, 2024 at 09:39:35PM -0800, Dmitry Torokhov wrote:
> > fwnode_get_next_child_node() always drops reference to the node passed
> > as the "child" argument,
> 
> As commented previously,it might be just a documentation bug. So, please

No, absolutely not. Consider calling device_get_next_child_node() with
"child" pointing to the last child of the primary fwnode.
fwnode_get_next_child_node() will drop the reference to "child"
rendering it unusable, and return NULL. The code will go and call
fwnode_get_next_child_node(fwnode->secondary, child) with invalid child
pointer, resulting in UAF condition.

Also, consider what happens next. Let's say we did not crash and instead
returned first child of the secondary node (let's assume primary is an
OF node and secondary is a software node). On the next iteration of
device_get_next_child_node() we will call
fwnode_get_next_child_node(fwnode, child) which results in passing
swnode child to of_fwnode_get_next_child_node() which may or may not
work. It all is very fragile.

That is why it is best to check if the child argument is indeed a child
to a given parent before calling fwnode_get_next_child_node() on them.

> elaborate on the use case before this patch that leads to an issue.
> 
> > which makes "child" pointer no longer valid
> > and we can not use it to scan the secondary node in case there are no
> > more children in primary one.
> > 
> > Also, it is not obvious whether it is safe to pass children of the
> > secondary node to fwnode_get_next_child_node() called on the primary
> > node in subsequent calls to device_get_next_child_node().
> > 
> > Fix the issue by checking whether the child node passed in is indeed a
> > child of primary or secondary node, and do not call
> > fwnode_get_next_child_node() for the wrong parent node. Also set the
> > "child" to NULL after unsuccessful call to fwnode_get_next_child_node()
> > on primary node to make sure secondary node's children are scanned from
> > the beginning.
> 
> To me it sounds over complicated. Why not just take reference to the child once
> more and put it after we find next in either cases?

You want to "reset" when switching from primary node over to secondary
instead of hoping that passing child pointer which is not really a child
to secondary node will somehow cause fwnode_get_next_child_node() to
return first its child.

> Current solution provides
> a lot of duplication and makes function less understandable.

The simplicity of the old version is deceiving. See the explanation
above.

Thanks.

-- 
Dmitry

