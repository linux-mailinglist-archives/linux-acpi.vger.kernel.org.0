Return-Path: <linux-acpi+bounces-13754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76BAB9ED1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426D63B323C
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0729019343B;
	Fri, 16 May 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZOZ4DZN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39917B425;
	Fri, 16 May 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406630; cv=none; b=IZppfsl+FJjxJwbyonvOHAYcRO9fZz/eVO0aJypXQMVCAflglFotlOwwvQmoYDpeLzJhH1/DO1Kxa0LRKK4Abq0gS8sg2A3KMSDr5R8HWm8P5/CUfn3ngxoxMzO4+SZCASOmk/HPXKTiqI9UhPL6SsQtLTl+aRsa0vun9ErF9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406630; c=relaxed/simple;
	bh=YzbUiQFpN9CKduaFf9fZxDFys7At/fYbTOUhuPH1jcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsuRCwtkX38QPsxPPvxwNBn39pjKpuDq/KId9YnoouMozsDhGlAFUASyGwsGYNvKjQdF/72e1ncQGyCBIvWZUtFcJjFYgQEo+tH33mTdStEA/bb5l/X28zUsBsBZGbPtJdRIjkvdUFJ9B7gpFnN956/jgHOC662Nq1JBvEs1W6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZOZ4DZN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70a57a8ffc3so22880737b3.0;
        Fri, 16 May 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747406628; x=1748011428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB7ZVNbA4VwBkje69lx+7aRX+yawyONaVZRILFYAJ3w=;
        b=BZOZ4DZNEafVQGR9E8he1OlxuLOpK+LdGjMWtRaCKIiJKbnAA/eAcrEBHfVDw/Zwof
         +nYoVt+y+AlG+g/3xAJGx45MMadpHII3fYhHcI6eysIG72zo7lsXaJR7qNQw93aNMzPw
         i4F2worqng6A9Mg5E7+flZF3P367afXGWIsMW1CjwKf8g5TwXFii2efCTY4A6NesPXgJ
         eGX1KSqYYs4Ts0h7qmtGtX1+Fx7ltwJxJGVt/PZSbYaJoUmbjBTHVj9khB46lcl5kyVj
         YP+aio9qTDMSfLIS0gsAn3u94RLTTvSbvyDIOAiHOi8mpFhGzuDFE92/8kdgdhR+F1xR
         VUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406628; x=1748011428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB7ZVNbA4VwBkje69lx+7aRX+yawyONaVZRILFYAJ3w=;
        b=YU+bH61M6ued5aRWGshTuxuSVV6oMTwB5NYH4Kmuz6VOzPB0YuL0tu+YGZR9tmlAIC
         gH4GRH85YqP2ycwFxF7u5TKtXK0NC2ExkUbzNE3cDGrhiJDygIht7kJQ2OHilBjXHKfA
         HUq28a+ML47Zn54zKKb0MkzErlpt8pOmi+U4s9yNZ8DlHCoaODKRDWWSqvUpIdUa9U1b
         0kR8EkdUM+P9pY8L2YISLhWkUDumOmM34LpmeVrygZW395+PSWa9426YOEbN8aLVberV
         KKla3RgdkQkpF5+pQ4m+vIDbdX+hfQd4I03UhdaMjSUT+u3V1BFm0A7zq8l48frroLWi
         v8wA==
X-Forwarded-Encrypted: i=1; AJvYcCUDx97yZ/oishXbhzDlJ0nQ7n5wxQwk3kT0ZK/dwpDgItykd66x5jO09tA2VDkdzzb6ZSPUmxV4v/fU@vger.kernel.org, AJvYcCULE8Qup9p8bOm0YKWtMurUG4WzsTIlmk+O+GXMWXGbgXPGFnXd4VEbzgT1e1dz0/O4y5uiNaTC7XqLxaMf@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2VMvxXlApz1IwW/4keU+UThHLNL5ZUyItxy7wbsi5FqR6FJx
	KKBS61fObfhEYoJ63AePkVN5QVGz3VX8bMwsDQFMdOVFFsxS5JNfpncs
X-Gm-Gg: ASbGncuAq90w6ePAexxJEN9f3yJGqsrXH9fqYHuvYliIeZC91hKooVmz69ARQywTTKI
	5/EhV+guJsxMRV6KemI5H922HtFZWzkZ6b/0iu4vmHMZt6oukCroL0xQx+ctpgXPw+fgmQsADLe
	ojWFZqFgbPbt3OmYY2pSH97guZ1bSz4spEBNsRPy8i7/DPi4BgCQi9TnlPlEPkzIThGoZ9acQ4E
	HD4Uz5miHYQckcUQrndcOF8M+eDqA6ijZSpyJRPE8v+9uYyRNP7TNkZYYI/GN54+1yl0eH8WndV
	rhDoMWoBUnRlLPpg4R0jzft1kdQN6unwa0Kr5SED60GxPvJwCCE=
X-Google-Smtp-Source: AGHT+IETm0wo59unySxVA+IieesHyQENvv9Ekp5B2V5u9vrh75cH+pCi06EmlaQKDYch9oyNl44DiA==
X-Received: by 2002:a05:690c:ed4:b0:70c:8f0c:f923 with SMTP id 00721157ae682-70caafcf16cmr44093937b3.18.1747406628006;
        Fri, 16 May 2025 07:43:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca832404esm4393767b3.50.2025.05.16.07.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:43:47 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	gourry@gourry.net,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Fri, 16 May 2025 07:43:45 -0700
Message-ID: <20250516144346.8545-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <7cf5da27-4542-49f9-90e2-88ba0eaba682@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 May 2025 13:37:39 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

Hi Andrew,

Would it be too late at this point to add Honggyu's Reviewed-by and
Tested-by tags? He has helped test and review this series from the start,
but I must have missed adding his tags after rebasing from v7.

Sorry again for the noise, and thank you for your understanding! I'm not
sure what the procedure looks like for commit messages... but here is
a fixlet if that makes sense with you:

 Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
 Suggested-by: Oscar Salvador <osalvador@suse.de>
 Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
 Suggested-by: Harry Yoo <harry.yoo@oracle.com>
+Tested-by: Honggyu Kim <honggyu.kim@sk.com>
+Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
 Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
 Co-developed-by: Gregory Price <gourry@gourry.net>
 Signed-off-by: Gregory Price <gourry@gourry.net>
 Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

And I will sign this off so that you do not have to forge my signature : -)
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you again for your help, I hope you have a great day!
Joshua

> Hi Joshua,
> 
> On 5/12/2025 11:14 PM, Joshua Hahn wrote:
> > Hi Honggyu, thank you for reviewing & testing my patch (again)!
> 
> [...snip...]
> 
> >> Hi Andrew,
> >>
> >> I'm not sure if Joshua is better to post v9, but if you want to fold and update,
> >> then could you please add my tags as follows when you fold this change?
> >>
> >>     Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
> >>     Tested-by: Honggyu Kim <honggyu.kim@sk.com>
> >>
> >> I added the same tags in v7 but not included in v8 somehow.
> >> https://lore.kernel.org/linux-mm/5fdd7db9-96fb-49ea-9803-977158cb0132@sk.com
> > 
> > I must have missed including these tags. Sorry about the confusion --
> > hopefully we can incorporate them into v8!
> 
> I found it wasn't again :)
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-new&id=c021f31a3b73d8e5ae2abdd658d837c44929cad7
> 
> Thanks,
> Honggyu

