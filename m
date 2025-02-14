Return-Path: <linux-acpi+bounces-11195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A01A36227
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7589B1703C7
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF698266F19;
	Fri, 14 Feb 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejFSEz94"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DD267385
	for <linux-acpi@vger.kernel.org>; Fri, 14 Feb 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547962; cv=none; b=udcG3RWMh5vosg+9zxmRbkyJ4DnGuCSd3qA+5SSv52ue1sEKGKMWTS9JSpyq2+D3GFBGrcAapEOAVJLMZxUF0RrIp7bF+VAwIvJgkTUsBJzziiXFkHLf16dq0bh7x44mDMGTXxlDDJ7DyEAvVQf1KE+yax6BPs7YqY4ETqkGT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547962; c=relaxed/simple;
	bh=gtnOC9laOvVmIp+eh36F+/EweRzKrpcKx8mKxySFux4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8iMTWVLprXHUQq+bCG+k9rNo4xLDsM1xSXIykJhTWeJxTPDIMfynvV0y1R8v3bh5Vs5uYLwBnBmTqv7gxyZXpAwgvLgdKEQfPajeaZcF/6usj6g+UqzKVoUzDq39V6xMvYS0LP9BD1316/7hxr48P95urLeXbxu1tg4HSGcdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejFSEz94; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dbdbdaeedso719519276.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Feb 2025 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739547960; x=1740152760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycd2hQRX4+MoV0caObCZeDE/nlrKiGekQLF9H7HPZGc=;
        b=ejFSEz94THW4NC/+QfIaH1M53hFxLjHVQQO5pyaOWVyXT2SCWpxV6Ngw8PkE37N1eq
         7kVsrBYWz90Her9MGiIkUK0YGm7OuXdEXL+vMeLQmOAaE7uYoK1cIMeY6e9xgjfiu8oX
         FZ6r2IPT2uITrh8NDGKvHjfDJq0/74VUtMBctMNsck+6bv6RoZIxNceb4vL3uYRLo/5d
         00H64mwoN+q44qsI4Xwpi4W5hX0kpIUdV/MvKk1IGnbZr6d02snkfT1BmaffuLxXdsAC
         SDRcH7O6v/1KLD9dSmjeHU6PRvHt2Z70gpNJeENwk9X4oCZkR/9PK6o5qLx9aM73cr3I
         +wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547960; x=1740152760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycd2hQRX4+MoV0caObCZeDE/nlrKiGekQLF9H7HPZGc=;
        b=WejAdGnrMiU9PFx9joxupr9a6a3DG4L5ncZ+40c+Ud005sRhGyUaSD9Ew43LTd8jqq
         C5QIp+sswX5LiBdRZxt/DSoAYSrYJ+QInD2XaTGe9mZk5yh3iuWQNz1a7JhWTlArVp4Z
         GOMMMEZMroticcIUBYvgI57DOn39E7kg8hckZdIjG1hKdNOhrGL4kADVoA0yaXpaYadg
         jak2UVLwBvg6STP//L1xv/cwhnrfXxEja9gVR2Ma7lZZ32q6+KojbNyZeC+jtjRyFphQ
         bGIvVi2qVytXMGVnJ8CHRooLKy55cnneLvb7t1YA8xDaHQPPjKgRuU8dmqIXsWps6mW4
         ntqw==
X-Forwarded-Encrypted: i=1; AJvYcCV22EenYOOygWRlKYjXsvEixT31Vq1YyrxODZGaoksGstO5tNIC4lvkcfcxzcQrEwgCqJ9FVF5oIqMa@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpGwCQzQ05LJ+OxhbOVXfFAEV+mAf8I0TMPF4SXzsv+t0nldH
	nmBgNdNeBa+tMQa84MCrDLm4bEDusRs40PCzPM8MclPIwDrV2qTo
X-Gm-Gg: ASbGncsXqkghWkOdyMr/05hztoXVO6IzkupjOI91vWaqiVi4pEfeJH2WJTqYmK87YVz
	O1dJqlwYzj+ZaXD+NIVc7zvptrg5zPuO1mBCEMuL/99mY1f+HELWszBc+piaxOqEWjyPUzNyXPo
	R8rwRarWVreZZAefT8IabOJPj1oqVc6EwkTHyXtmE/WGZNtXNHyIiXk7iU+GafBinWRtIJ+eQNv
	ZNusPrM9sBBnxYR197jX2D5iDBTLMBnI7flPDQSbVC5zmhtnCDEbK5K4Hm+zAw4rWjsVwjfXBcW
	ZrS45BmXyKchlIA=
X-Google-Smtp-Source: AGHT+IEbhVggH7lAbaMjzwEbOSlqEqdNkutZljo10EJI1cHWpmYtYE8XuonJl2V4uCPDhcB9pw/c2Q==
X-Received: by 2002:a05:6902:f0e:b0:e5d:a785:464 with SMTP id 3f1490d57ef6-e5da7850564mr5151137276.18.1739547959974;
        Fri, 14 Feb 2025 07:45:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadb6d819sm1085360276.0.2025.02.14.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:45:59 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Fri, 14 Feb 2025 07:45:48 -0800
Message-ID: <20250214154557.329912-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <87tt8y1vem.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 09:32:49 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Wed, 12 Feb 2025 10:49:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >
> >> Hi, Joshua,
> >> 

[...snip...]

> >> > +		weighted_interleave_auto = false;
> >> > +		return count;
> >> > +	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
> >> > +	if (!new_iw)
> >> > +		return -ENOMEM;
> >> > +
> >> > +	mutex_lock(&iw_table_lock);
> >> > +	bw = node_bw_table;
> >> > +
> >> > +	if (!bw) {
> >> > +		mutex_unlock(&iw_table_lock);
> >> > +		kfree(new_iw);
> >> > +		return -ENODEV;
> >> > +	}
> >> > +
> >> > +	old_iw = rcu_dereference_protected(iw_table,
> >> > +					   lockdep_is_held(&iw_table_lock));
> >> > +
> >> > +	reduce_interleave_weights(bw, new_iw);
> >> > +	rcu_assign_pointer(iw_table, new_iw);
> >> > +	mutex_unlock(&iw_table_lock);
> >> > +
> >> > +	synchronize_rcu();
> >> > +	kfree(old_iw);
> >> > +
> >> > +	weighted_interleave_auto = true;
> >> 
> >> Why assign weighted_interleave_auto after synchronize_rcu()?  To reduce
> >> the race window, it's better to change weighted_interleave_auto and
> >> iw_table together?  Is it better to put them into a data structure and
> >> change them together always?
> >> 
> >>         struct weighted_interleave_state {
> >>                 bool weighted_interleave_auto;
> >>                 u8 iw_table[0]
> >>         };
> >
> > I see, I think your explanation makes sense. For the first question,
> > I think your point makes sense, so I will move the updating to be
> > inside the rcu section.
> >
> > As for the combined data structure, I think that this makes sense,
> > but I have a few thoughts. First, there are some times when we don't
> > update both of them, like moving from auto --> manual, and whenever
> > we just update iw_table, we don't need to update the weighted_interleave
> > auto field. I also have a concern that this might make the code a bit
> > harder to read, but that is just my humble opinion.
> 
> I think the overhead is relatively small.  With that, we can avoid the
> inconsistency between weighted_interleave_auto and iw_table[].
> struct_size() or struct_size_t() family helpers can be used to manage
> the flexible array at the end of the struct.

That sounds good to me. I don't have any strong opinions about this
change, so I am happy to combine them into a struct. I just want to
make sure I am understanding your perspective correctly: what is the
incosistency between weighted_interleave_auto and iw_table[]?
If I move the weighted_interleave_auto = true statement inside the
rcu section, will the inconsistency still be there?

Just want to make sure so that I am not missing anything important!

Thank you again for your great feedback. I hope you have a happy Friday!
Joshua

> ---
> Best Regards,
> Huang, Ying

Sent using hkml (https://github.com/sjp38/hackermail)


