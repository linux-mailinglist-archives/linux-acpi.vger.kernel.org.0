Return-Path: <linux-acpi+bounces-10269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47679FA6F3
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296B0166716
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27113A244;
	Sun, 22 Dec 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WnY2g6vu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3638DD8
	for <linux-acpi@vger.kernel.org>; Sun, 22 Dec 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734886500; cv=none; b=JSf7ZNnH2Meq7K8ww46dozkDnB+7Q0/qKjJRkrRIX8V+D/33dWCPs/KMu3fSAMa8ge83T11on8aP01pKvQsfA+JcLkOkhQSgygfz5g6umSAeWicT5ZMEldUP95ij4UERFXzfbYjH/bE1YXkyjrsaL7zzmZzgyPhBo2xj0ASzqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734886500; c=relaxed/simple;
	bh=3kVV/t+LfJVUVFb3yfQJTyc4hcNhp+E8O7//zl42fEc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO8P+IdyBks29iDpn0GMn2Tzqr710q/048hEHS5279dpIga+SdVKjh4mOrqG1YpHOdIs27CXFtYrFO0+UrlOLoDO4wRgq8+rmuJSChBhwZAoR1idJ4yaEwWCvFo+YKOwzy3pBJAOpv3Li91rLiAO73g1JrqPenSdePEwMyrlE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WnY2g6vu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e729562fso2804185b3a.0
        for <linux-acpi@vger.kernel.org>; Sun, 22 Dec 2024 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734886498; x=1735491298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwFeOkelH/d76YL3GbRBJ14O8JH9pLtT8BqJFo+zIGo=;
        b=WnY2g6vuYw3lMcMBKZA2+e9DveCcHEnXkt7d2EFH4m+CWRGFmShbH5Lu8upfCJ52wV
         CSJ2FjLCHq+WOpTgorYlJrtSToXYxti57CghOvgMw0Zk7PZ8xl2js17dFwbLOIdj4EEy
         HoJOjxJjupf68BBCAoyuyn6sTggFQi1gJkS4C+3rB3/Txsni2XqLIztjUlTLutKyrjS6
         CTYwUjq7hygD92GPSYhT7Y1CAyT1E79oOeTBS0x0z+KEXpPNREWK2Ll6oNe5yMnBQbaw
         M4lAoSzFOEWvU+sfynVTZC+eo2uInS+0ls9SyUaSnldd67dnrhhSaMAUeEJKgkwrkde3
         filQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734886498; x=1735491298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwFeOkelH/d76YL3GbRBJ14O8JH9pLtT8BqJFo+zIGo=;
        b=sHIqFLTOQqmUjWm7wt+XrpbTjTjUdNieRRu/88zsVqjqevLF9lzFmOYB3Qi2x00R8+
         yvD3ubReKLwWRktckeDZ4qibegWbv/La4d/V1GI+F+5IRxWssWZrTeiXrV5hFPyG70Zf
         HjPdhb+SvjnNZ41zIYN9XGHxKydJMiDg6qDCbsYG5qaq+/gvkHGrGc2TfmeYD2fxMEIQ
         gKsCKlorYYrB1xgjTaPOnctQ4kgIUG3Y2r16VFbHWWkYUeSAE6qoE+QL3fj3+QSFzU70
         iYB/oKPssKXAN58glv1WO6ODI2ieWfHlAwfPooaorvIN+skucJZe4gHbFEdjpqD6nY1H
         36vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5OBKFce7Sw9k1uOT3DoX2zxnEXwRmERRcqhQMekpS0VoZkHPrlcZEM/FRleAPA+1tQKKlaeehY+ma@vger.kernel.org
X-Gm-Message-State: AOJu0YxEX4UO+UerHZik8EkB9cvWGsnYgFxlyPaDgJkYghk6FSz5DcIk
	rBgRaGT9ipwIoi78DRZdIBPn6rtzzTsFmzdun8UcIHFvf1qbhYbtg3G9n58p+ic=
X-Gm-Gg: ASbGncsIeJvwk9hJYKurtC+7tbiZWe4wmapgqhlSwBbKNl/4V2W2e01e13eRIo24rf3
	bedcQvCSnTJ/sJOfnZANEOP2MpUfCWOddH8lG/mom0I96Fq7JHVi+8FmZZMf+Dx6AZuwxLDiKuh
	DaztGP+uNGT4EXbLA2eh+qQ/ktHQXGfnxKjkT2qo77PWHasN6rlTFGN/9wugTf/MgeldBxxVLO/
	7P7Bu0nA+Eg3URvD3VvAqDy/O1+mXVvFkR5noSQYklZIqia3zpT5dHxJ7usbAYBpvpLQNvzfj+w
	m/6Dqgo=
X-Google-Smtp-Source: AGHT+IGHojiWxv+R+SlzYUtKZ8OeWCiY4TrI+YqHVqyA+5s7qFOMJpjjEP2lL3tQQSQnG7005vWmfg==
X-Received: by 2002:a05:6a20:258c:b0:1db:915b:ab11 with SMTP id adf61e73a8af0-1e5e04946b1mr18102850637.24.1734886498529;
        Sun, 22 Dec 2024 08:54:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([75.167.163.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f44sm5911738a12.15.2024.12.22.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 08:54:58 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Sun, 22 Dec 2024 11:54:54 -0500
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
Message-ID: <Z2hEXttgNMjAo8-q@gourry-fedora-PF4VCD3F>
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
 <20241213195754.2676135-1-joshua.hahnjy@gmail.com>
 <87jzbtr315.fsf@DESKTOP-5N7EMDA>
 <Z2bXgMw5WPCqwGSk@gourry-fedora-PF4VCD3F>
 <87ldw8i0id.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldw8i0id.fsf@DESKTOP-5N7EMDA>

On Sun, Dec 22, 2024 at 04:29:30PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:
> 
> Another choice is that if the user set a value, he/she set all values
> effectively.  Even if he/she doesn't set the other values, he/she thinks
> that the other values are good, and more importantly, the ratio is good.

This is probably the actual way to go.  

> If so,
> 
> default_values [5,2,-] <- 1 node not set, expected to be hotplugged
> user_values    [4,2,0] <- user has only set one value, not populated nodes have value 0
> effective      [4,2,0]
>
> hotplug event
> default_values [2,1,1] - reweight has occurred
> user_values    [4,2,0]
> effective      [4,2,0]
> 
> In this way, 0 becomes a valid value too.
> 
> What do you think about this?
> 

We decided when implementing weights that 0 was a special value that
reverts to the system default:

  Writing an empty string or `0` will reset the weight to the
  system default. The system default may be set by the kernel
  or drivers at boot or during hotplug events.

I'm ok pulling the default weights in collectively once the first one is
written, but 0 is an invalid value which causes issues.

We went through that when we initially implemented the feature w/ task-local
weights and why the help function overrides it to 1 if it's ever seen.

We'll revert back to our initial implementation w/ default_iw_table and
iw_table - where iw_table contains user-defined weights.  Writing a 0 to
iw_table[N] will allow get_il_weight() to retrieve default_iw_table[N]
as the docs imply it should.

~Gregory

