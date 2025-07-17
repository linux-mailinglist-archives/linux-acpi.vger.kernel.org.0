Return-Path: <linux-acpi+bounces-15225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A9B0937B
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BBB3A4760
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AE2FEE13;
	Thu, 17 Jul 2025 17:39:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A82FE321;
	Thu, 17 Jul 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773997; cv=none; b=ojdthpQMWlZV9TUYiH1GbTn/uNCu8nO+bC4HxyqrhpLwBJ2oDtQb4Qkq5Dr8Duc772YyaA5Ej+Cq/XuZ4ToM6oKG0Aupx0MnxKVx8W0tXlDAkACt11fozffe1PmHcyQa2TnhwA5s0aQ+bzMMyt8LutXdpR5U9pfqbdg3z/22lU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773997; c=relaxed/simple;
	bh=qkhhPed3/lpu6pQkUFh0Et55Y3tu/w9wjUEBEqiMqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHuYYso1/CpnnrMg6p4Es1g1pBB6FGjxzgdpt9y1j4Alhvas/TDJZR2PQFtHE24plpsmgqeJLtB5LLdY8wykzMvUEjjgoKf/AeYzGtu6RQzSyxadP3He2dq5SPWq/nXU5P9dktsB8iMZ+8tDL9ahMWtNh/Z672H+eeQhqGm38Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aec46b50f33so234346166b.3;
        Thu, 17 Jul 2025 10:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773994; x=1753378794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N75hUCUnHzHAOQnR1X5WDi46d6HHqLedahkb72BGIp4=;
        b=b9xccUamY3BYoh2Ck54Q8/bkNItCp30s/k6ExRSnNKSQSIjeZrxxH6SlYH9MT65NgR
         5hffBV0haCfudFGpnlsscOkQmTJtI2aKQKTHCx9gVZi1lOV6G32qfTvHekhPJ55PI8I4
         XzTzifmUZjpWv12NTWT5eEeURNJpN5PQFheex1buxTnxroHU0SjHzYJSjbpfdIV+6H4+
         HTxUlMMUsMTjH/k6N3yLMvi44UPDhxYGiNXdXPP0Kmr3xm19DaE61EydyTQSGrjEkhDX
         LqW/JczH0Hw4Z8bIL3PPsQ8vNvKTs1CFUSa4i4ad50duUXzA2qslrFiAmPCmdDtnVHM7
         sGkg==
X-Forwarded-Encrypted: i=1; AJvYcCUQdOUK7/C5223gKKZL88LCyuQtskz/Tg1yn1WU1yPG5UXXysMA7DZP6xn5AyfbuH4LNvPJx7UHWn0o6Dqu@vger.kernel.org, AJvYcCXBY3PkQNRyZXJhTwuBP93004bjs3h1ER+Um+1iHpLJ1hoQp0Eux/24ygJVOc+ncnweiaYMtGb0dlth@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40yup/bRSfAZ2j5b6AuoFVH119Gk3VgZp8oZnHstFg5+yrf8x
	xJal2VyTRDPeDgGcESnNg/eAVm29ngOfKYTD4m/GQRUv7d5+90MB4IjA
X-Gm-Gg: ASbGnct32cPRUC4HNyMpe3u0M0QFz6JxQ9PHyHAk7cR3vvSmjo9mccDak5/+URK4h4Z
	3nI1OH2TpOHApWXk+nkO8MRWiRcpI1wb3FcWjK2ILMpQ0MLLZCDk8A61faVxPOH8Hgu14H1bTDL
	EpYRHf8bmDVoerCRD0kswDVsVuCJfeICgysRsnumv8enOFeNMt9278fR1jsfiAI7YB2mta/UTLR
	O2D0PzYYYE5dR1eS8tb/BRqSH7ytcVjzFZj4YComzOKDCMP2eKcLxShuxwpOyc1o8J8a6++UYov
	JZFQNBGkcQkrvfLnMcpPexhhfSfyxpl+Gt79GNE374/6jpz3ydvpK+szjav/EZoA3qL3VenzS/E
	Midz4LhkhvscpuA==
X-Google-Smtp-Source: AGHT+IFzyhLjmPmu4cDWktpxpzqDvcGCAjasZsDpOpRd6cqtZ393AWPrIrHoAbTP5fUy+pRG6xJk/g==
X-Received: by 2002:a17:906:d28c:b0:ae3:ab68:4d7a with SMTP id a640c23a62f3a-ae9cde2e5f3mr674693866b.25.1752773994024;
        Thu, 17 Jul 2025 10:39:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4860sm1381138466b.47.2025.07.17.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:39:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:39:51 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, 
	"Graf, Alexander" <graf@amazon.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Peter Gonda <pgonda@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <p2jxuwlierrzbgsdjdmiw5336mhj5s57vg77zkekix6fkjqbqi@sa6opsvnxv6d>
References: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
 <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
 <58f3242a-e52a-46a9-9a99-3887eeaa1285@linux.alibaba.com>
 <4fbreveuibi7q5nc2v4t3fpaxrgpwfd4f5c3ubfhssidqesax4@n7q4wrdpbfjv>
 <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60838F74FA06ED06C5D29FEDFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Jul 17, 2025 at 05:19:48PM +0000, Luck, Tony wrote:
> >> Personally, I think this approach would be more helpful. Additionally, I
> >> suggest not mixing CEs (Correctable Errors) and UEs (Uncorrectable
> >> Errors) together. This is especially important for memory errors, as CEs
> >> occur much more frequently than UEs, but their impact is much smaller.
> 
> Total agreement on keeping corrected memory errors out of this special
> handling. They happen all the time in a large fleet, and are not significant
> unless the same address repeats.

Are these EDAC errors? Shouldn't we track CE errors in
edac_device_handle_ce_count()?

