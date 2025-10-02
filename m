Return-Path: <linux-acpi+bounces-17521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9368ABB59B5
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3B9485D5C
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 23:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0328850E;
	Thu,  2 Oct 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zvmvojs2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF5264602
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447318; cv=none; b=n9julv0IDabOruF/RQ1oNLzq18Y0/B0JRLI6EqAwjcLMRZOw7QvQsyOaSIwTg5ZKTHpBevdALqHxxfci48uLa/jNaRIGGmZ4Jtjfcx4vxVt1U+Pf7NZ5T4VMoUy7Vfrcr7Y0Ayr/B2XrGNpfMfgTwg3faMh9eIm2V++Zdc44aDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447318; c=relaxed/simple;
	bh=Q9piomNJadBCp2fiMxMHhDI9JaKKkht2y11msmtagbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUJl0cZtyverUmMtiBdAJKI+y4fovaIjbtPhb/jnT06c/wUAcC2NaxvBONEL1yllW5T2F9TPNaNdx8dqTQxuZS44BqXjVmCH5PzVpp3OT9O6fW9KeWLf4wfzVRlCDFHLIqeVx2Z3oxZqOZlrcD8/gqQyCOXvn5qlffia1d5wFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zvmvojs2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso11160521cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759447315; x=1760052115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4Q5TvUjGnT97o6dwT74PCnUgaEQ50n5wSe+czl475E=;
        b=Zvmvojs2n8b3DHVvodSX+cfCCzevEBuIGFXL5b7FE1aFZVS/fUqtL6aww2nYp9UwtY
         j3O7gjARV9OpgkD6Pb34SQw8THiQJ7WAqZLyBiAvdL08ZB3TV4uu3DFr8RYJA4EfoYOz
         C5B4rnwC0p3+FoxFZ4M8t1YlSu7zsFiMlJgfQ/vRGewHALwOIm5khWqClL5wukP3URo5
         H6yUFxNlaI9yFKi90QzskI5SsfvL13Y3jUa6XJssg/bYQqBUBn0KgPdsO4s/20MYKDU6
         Vj8tcbrwO304Tkk9Zhx8VF4f+OYGOip8IzGsSoh7y8Ydn2KmzQhuN3yjr5lMgyj5NNWS
         OAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447315; x=1760052115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4Q5TvUjGnT97o6dwT74PCnUgaEQ50n5wSe+czl475E=;
        b=Kjw3YxioHTUi28LWARTJjVd2o84VeyYo/jL+zluniC8wEXbM3PWFasdhuk8EjN50wO
         /phPxEB/Y7jrw6q5vzgjXDI2NO48qA4teQYansYBcngz0k4jq8X8m8pNil6MZR7/VOcp
         0/jm01pdoaXey9q8E/VyjuBAI9VPAyk7BTrVxe6BWhmn2r0qLTsv/Xp51IQ67HSHA3+r
         yC99mYkTccco00X3uMSkw6MbVvBTKs6GJuh4HvgEtDXHSzEGsvZzf7v8mXYB40Fn5FAF
         6mLb9d7FvIs3ATtNveEIVPwaqMvOBF2gTkwMOLvNezq0AT66MSbEIrv53n0/bF5a4T+p
         vyfw==
X-Forwarded-Encrypted: i=1; AJvYcCXZeGZTxoRXS362Y7iZDZc9XbjRuQ8qV9AZ4bF7ucMLDDioSMWoz+B7LvqT4hDLW0LwTQ5EdFUDWQWD@vger.kernel.org
X-Gm-Message-State: AOJu0YykUwqb4fpufZifg1l1Ql+QQZb0riOGRP70clpxVSEbTU5vNyz1
	w4yEAURjqAkKlf7d6iouAqieI+7GFi6FfoPD8xIrIEEZYc+Ia6HINUfl8IUqac82rZI=
X-Gm-Gg: ASbGnctVLbER2dOgr5U8ui0TNBF5s1xiEsTnjQqxMHGzV85LVSiBQao8fD120z4a8Aa
	RYPi4Fmb2L7gcA3xC8pxPXma81zFmPR4rhomdVWi3zpIXxdQtDCkO9baqwkzO08shjzok565fel
	aM+74s7n43MbHx/2DzzGjG8CR6Le4wbx3U+smKJ1O+lJIFHgLz+09ok/GT0plP2LTRbxYuMqc+H
	1HKw9VOqbum+At7qN8+BSHL7NRkDwXFmPnH+ohRmGC9yJ/8vjRN1GFaL9pZ9+/ujKS+xBuXmO/y
	CPqbual1B8S+G0UoGsjUvwetf9+2yvkRK3zehkQ+QVX1nYDB7z1n25kVxuav1t8oCpP68ytic3y
	k0DJ62OeYG3MtsQLdinI98NAJgdMSrxEoIh1vPqigBJSxhODmSR7p3wQq3gxHTq/jDxM9+xZTMi
	k/FKYjo5M6V4HVOdX9
X-Google-Smtp-Source: AGHT+IEWbApPpoYIPJegt+iiGZZw9VIY52dxn/8hHI3G948Gvy7kTmzBDX0DIUJHAUyutFT5hXVSqg==
X-Received: by 2002:a05:622a:14b:b0:4d8:531e:f896 with SMTP id d75a77b69052e-4e576a7b75bmr18718281cf.27.1759447315472;
        Thu, 02 Oct 2025 16:21:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55af265a4sm29033531cf.22.2025.10.02.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:21:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4ScT-0000000E1Uo-2AKk;
	Thu, 02 Oct 2025 20:21:53 -0300
Date: Thu, 2 Oct 2025 20:21:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251002232153.GK3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>

On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> I'm saying the only drivers that actually needed to implement Live
> Update driver callbacks have been vfio-pci and PF drivers. The
> vfio-pci support doesn't exist yet upstream, and we are planning to
> use FD preservation there. So we don't know if driver callbacks will
> be needed for that. 

I don't expect driver callbacks trough the pci subsystem, and I think
they should be removed from this series.

As I said the flow is backwards from what we want. The vfio driver
gets a luo FD from an ioctl, and it goes through and calls into luo
and pci with that session object to do all the required serialization.

Any required callbacks should be routed through luo based on creating
preserved objects within luo and providing ops to luo.

There is no other way to properly link things to sessions.

> And we don't care about PF drivers until we get to
> supporting SR-IOV. So the driver callbacks all seem unnecessary at
> this point.

I guess we will see, but I'm hoping we can get quite far using
vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
in-kernel driver entangled in this.

Jason

