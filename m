Return-Path: <linux-acpi+bounces-17374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720CBA623D
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3217B247
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B932206BB;
	Sat, 27 Sep 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="H76AWMDE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE901F94A
	for <linux-acpi@vger.kernel.org>; Sat, 27 Sep 2025 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758996377; cv=none; b=ApxfKyYFXAwcJnpEIaZIHh0i8RcgNNS7robIEa1yJexHI8YHmSWuCTTT07WNzfIBRmCoQKaWT/uRXKUKbGnU1xeUk994HaEVhC1dlFYgkBVIpNs6sqqefm8NGDg95bUqHdJ6y0/Vqx2RrwAf5SLHCqLrb87cTL6DSkqkbYPV5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758996377; c=relaxed/simple;
	bh=za3zvUL8SxkFCz68xzHlumy3WxqeoawxW94jKlIhq8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ8aicTPziN1LcBqZ+mTorMdA3A2MyOYuLBFu751M6bCfTYlg+r58ZpdA6a3MYiFGiusXI7T7UaGvjAJln3ZExrwVSoRN6hr4gG65P4u5m1uonE/f+m104kiu2J4CFTKcjxjOHYhOSHfsaohtICqiRcyRHBdKDEhRo1V6xIXZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=H76AWMDE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8593bcdd909so332006485a.3
        for <linux-acpi@vger.kernel.org>; Sat, 27 Sep 2025 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758996375; x=1759601175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdVHqiyAlzw5VOmWhe8awo/oWd+izml4/2QfCryMP1E=;
        b=H76AWMDE761FpvjQ4z30QS9UdzLm4sW0sP0Toa3aYBH6bW3nGyw4523ob2ZeKAQlVm
         ltIhoZu0a3a4wj4FLyUlfferI9Eb1K8JiDJYfuYV4htHOrA0U4wzZGSrm9pnAHKQGTFy
         Z69LW9fRgppH1YFG8XU6aZNO8rqEl7fAeaFsRPUmGuJ1CriSNs7/rCyFXklywd0weAO5
         fYgre6K/jaS4A60mMxA8sRQBKAgof4gl8kTfmaT7Mn2cxNw8jHmZvgqp03WuDNoTz9gm
         Q0UkoaFe1pOrTKbCebTKv0csNgwc6eOMc3975EgnCwmbvVxs0BGF4mE+LZiBPKuk/K//
         jK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758996375; x=1759601175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdVHqiyAlzw5VOmWhe8awo/oWd+izml4/2QfCryMP1E=;
        b=o5Yeflfd16eNiHBkDMFi5bx36fYIRSocXDiMLs6cgwZrqJNOerJzJNZJOCcWQGsRdx
         joe0+Y1sjjSUGq3EiBjdal75LFaxUtG417t/27nAG3gaRFGoamnIEiz1TBIsD8is/Tq4
         LFhshUjDyQ9XFZqxBnbtAYOZvMICML4UNNDTBpD0p+y2v6vhpQYtrsVEKYxZD9yaaMV/
         6DE7/VYBUsRf5p3tAQ650avFgtH9Ywf2SZjRJA7shUMBKRgPLXR7YuktagG4oPkDJEly
         83quT1MMUjZrIUWWtZto0Hi4jemEQXDxORlLbI+Gk5AZaUurAE6f/4QlTpfW5acrURCS
         mKeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNIF6RA62OqlyM5sejdFy65QeqDV3sUiL1sv+HSA9FA/dxUAlKCFJnPfHymYCM2gfZK8n6Bn0+jBU8@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRMAtiT8l/PcdsZSHBy4GHKZi03ibt1RSpuV3n7oYQelVRNfL
	p2J6MhkPQjlUhD+C0aYO8CdBD3yUtlmn2yfBAszRknR5bLWHxvHPu3QVOdsiimkIyLQM+o4RfUE
	sCsTEptSOmOD17LCPK1/I6gT2iExEtKlZWjbYoRaK3Q==
X-Gm-Gg: ASbGncuU2mzTkLcwB77s288BVMcjRNdeAWbGJeSxKRfy/sZbO6+qVbIRbIYJGUfmfps
	QmFC7scniy1Bgh4aJ/46E23jmW8g9bwMUgpe4WZY9rofePagz90VjHzNX7gp0pia/wGg8k+RG92
	vUU7iYcalrNdk4p7BTIP/0EsijOCScDbjdGO+Ad7KFS9DUioFpG1wuIpDfdqriHE3mV2YYgH0rO
	igPUTAEl4tCI1g=
X-Google-Smtp-Source: AGHT+IH0hkC5qp+kzEtV3AAYGe6it1JS4/y6NEysHV1y6zn7mbZJQ696CJMmKCXewsNF7vFFFMvp/YeeTwbqIflnmoc=
X-Received: by 2002:a05:620a:4402:b0:862:dc6c:e809 with SMTP id
 af79cd13be357-862dc8b7607mr820813685a.49.1758996375263; Sat, 27 Sep 2025
 11:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org> <20250927171356.GA20865@bhelgaas>
In-Reply-To: <20250927171356.GA20865@bhelgaas>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 27 Sep 2025 14:05:38 -0400
X-Gm-Features: AS18NWAnH9KUAM_KKB10VKxYTihmutSj1aLkSs9HLpJN6HemSHpsSyGyQVSJndM
Message-ID: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

My latest submission is the following:
https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.=
com/

And github repo is in cover letter:

https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3

It applies cleanly against the mainline without the first three
patches, as they were already merged.

Pasha

On Sat, Sep 27, 2025 at 1:13=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Sep 16, 2025 at 12:45:08AM -0700, Chris Li wrote:
> > This is phase I of the LUO PCI series. It does the minimal set of PCI
> > device liveupdate which is preserving a bus master bit in the PCI comma=
nd
> > register.
> >
> > The LUO PCI subsystem is based on the LUO V2 series.
> > https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@sol=
een.com/
>
> Pasha's email points to
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/rfc-v2,
> so I cloned https://github.com/googleprodkernel/linux-liveupdate.git
> and tried to apply this series on top of the luo/rfc-v2 branch (head
> 5c8d261fdc15 ("MAINTAINERS: add liveupdate entry")), but it doesn't
> apply cleanly.
>
> Also tried the luo/v2 branch (head 75716df00a94 ("libluo: add
> tests")), but it doesn't apply there either.
>
> Am I looking the wrong place?  Do you have a public repo with this
> series in it?
>
> Bjorn

