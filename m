Return-Path: <linux-acpi+bounces-15171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD9B06515
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B34567E18
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A5281513;
	Tue, 15 Jul 2025 17:25:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A62B9A4;
	Tue, 15 Jul 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600353; cv=none; b=JpQ04G31MVK6FKzOYr4IQcF7Up4UOV/VNF+asFidMUJ7QPwNs9CCwQqk0YX/bkVOGbxxwr3ODG1SKRn13RKU1CA1QaUfSaIP+OkSXJwQ13FC2BJlrmW3XgWm+HfvB0yrMX7GO3Qe5r+kuaAr7vhilQ1+n1CDhlUJTO1wSAHzHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600353; c=relaxed/simple;
	bh=ObNJkp8w8dckS4HfYzBEO63j0fpZbJAJtHbLUzQTMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqzxqV1ycOq7NglZWJpqQHgXfv/uilYLE+o57hlAbbssO81ZoWR2kFUjoDWJu+AxiH/FIdjRjKdSoHtaEfxyQq0YbWM5bj0YyDRVXt3kdJ2jrPyl67MC4AgcfI0GKpJOoV6F7qtRoLaP4mMuKY9VWwOSN5mjSKP8bM/FZhTAriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so9507405a12.1;
        Tue, 15 Jul 2025 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600350; x=1753205150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf1dUxpG80FVASwwBORzwwbeN/v/ksSLNBI/P0k3Gcc=;
        b=IcBGNv8T9C7+ohtu/n+CyrRthz00+QiAI4Zdk+wQ71R0CJFrT3ykadLzi81Mg9ED6k
         0jE/TX8x71WVv09k/wEtaM83FVMTX86Xuv0YcqKcDJ/wlw+tV5dEySB/5MKaMGGYiMxx
         bjhOpLyQBhEaay5R3nakH8PTAoefjR4QswvX96iuqeW642QWEIu3X9wzbL2IN16D2B95
         qHDSColhSi774JA7JMEeoVcQWbD2OxLFHVmR6cNEuuULPuV6ErGGskDFs+bhjZRuwdqY
         DIV+Yo8XbL1F32qkZn/2IsxYh4JtZaPijI+sSi2XMqm5BmoTYTssPXFp1lbdy6Jng8mg
         0FIg==
X-Forwarded-Encrypted: i=1; AJvYcCVlwwVwqvSyorKewkdPNStD1mKXUloySgcr2wQ5yFXXbX9s/884Tt2OSDC+07hPpMtg3Ugins09RYIT@vger.kernel.org, AJvYcCWcoNtLTQPT5O5I3jUVdQRFa5BMoOleKk8SPoGfmmMtbGm0Kc1icO6isX7yRgoqcWTpYIcG6nbvn+f9EOsK@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpBm2ZZXh16bBGesrUAuiXcwMxI6YKpF/UnsfjCrEYB+YV0ep
	P9sr8RQQ2ODAIEZwT2vjKj9TjI7hC2sK2QpTLJMDcgYwXeTIpOJy38xx
X-Gm-Gg: ASbGnctNvnYx+dZ92viKqfBRKoajQ7orfDZn+39yr4rgKtHPfF5PJsABVRoEQsgFQxw
	wxTvatAmO/i2J6N6vWBMDi6X2YGo4hRbGEh4K8xGF327Xgn7uogQyPsdT+DhFA21nuDnIXeAqdo
	cqZMY+uMwM8PS+QUKDpPI8pYFkLlCZXnpWer+xgZitWWNsZEqCjuGAFa0RtVHDtSiDK57sJ4qrM
	M1u/IBq95K0lcj1YiovhQbkhC4FuPkyjcNQ8csTRgwkL3HO1HNq7/GxfdDJM45+C1WcIMRkRY4z
	OUaON9vmWX2ap+kumRayvFQHJUoLfQJyk/yaJuwDsZOcx62Qz/NG16AuZQ/BJvnro/3XKKBnNeQ
	twHRAOxNAZTGh
X-Google-Smtp-Source: AGHT+IFeQYyxja+cmVPhs40k5Cb0GxRCsVCO/YLoPe8/dy4NpmE659Cs2eUBxOmp8tWCHkW96xjcFQ==
X-Received: by 2002:a17:906:b212:b0:ae0:b7c8:d735 with SMTP id a640c23a62f3a-ae9c9b6c4dfmr25479566b.42.1752600349578;
        Tue, 15 Jul 2025 10:25:49 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826651csm1035756866b.101.2025.07.15.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:25:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:25:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Graf <graf@amazon.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Gonda <pgonda@google.com>, 
	"Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>

Hello Shuai,

On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote:
> > It would be really good to sync with other cloud providers here so that we can
> > do this one solution which fits all. Lemme CC some other folks I know who do
> > cloud gunk and leave the whole mail for their pleasure.
> > 
> > Newly CCed folks, you know how to find the whole discussion. :-)
> > 
> > Thx.
> 
> 
> For the purpose of counting, how about using the cmdline of rasdaemon?

How do you manage it at a large fleet of hosts? Do you have rasdaemon
logging always and how do you correlate with kernel crashes? At Meta, we
have an a "clues" tag for each crash, and one of the tags is Machine
Check Exception (MCE), which is parsed from dmesg right now (with the
regexp I shared earlier).

My plan with this patch is to have a counter for hardware errors that
would be exposed to the crashdump. So, post-morten analyzes tooling can
easily query if there are hardware errors and query RAS information in
the right databases, in case it seems a smoking gun.

Do you have any experience with this type of automatic correlation?

Thanks for your insights,
--breno

