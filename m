Return-Path: <linux-acpi+bounces-12917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEFA82AD0
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746B47A83A3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678F2676F4;
	Wed,  9 Apr 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgKl4Y8u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5717A319;
	Wed,  9 Apr 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213400; cv=none; b=B4MnAjWC4botPH3ThPHF9PtLvTup1DTccwr4OpsPd2CmkCKpYUpLjjjAyoT7topZPdcJQXSgAci5i327QnF8p8q+WuXHBsAW38sBwjiJP2rBO1veDsbRq72uECd69iYX5eyltVYv40rsjuk9Xlp8qzAGs2WJv0MYN3p5lnZRmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213400; c=relaxed/simple;
	bh=k2miXl1ondWrQPYCbSibfKxqRNlBY3ts+SvGry/cRgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah/iVhnGGIzlh/NuqUYdDZoORyIwxCIu2jduF9BqE6/6nf9cC7uQ7vV8TXaDl58CwlajABSZ5c4B4UVR5m+fbWw/bqN9nEQkzRaaxVRxzNFlm3zTyV/85/gOxP6mcGBf2B0zOULVyvtA1jbAnPk+0iVzmNWW1bvbTS35bavKpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgKl4Y8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A787C4CEED;
	Wed,  9 Apr 2025 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213400;
	bh=k2miXl1ondWrQPYCbSibfKxqRNlBY3ts+SvGry/cRgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EgKl4Y8uJ+s5Gz5sent1TRwKfM8y2q6rYNnkUISndsVOhcV5LpclHSAOkCTqvQE38
	 bEdrWzlSUkQdYAWhZMRX4wGhQjtBToSEUuePU93eTJtlS40XgWyC85SO768NhPlaFr
	 CFKFBzHlI+d0jtv9QX2Hu2/Lql3iyhn7H93xc0zGY+bhPVC1js3JkZQfOVLM7cSRkp
	 jdsD8Lt4Sbc1iVHom025Jp91jw1191YzRdK7p1B7fHV9BoTAAX4UXnHm7FH2v3NV8n
	 sQqzaetf34PQVDUxa9U0w1GkF/eRiXEtSX/xg9wScjXmaOmtmjobAQNEnmx8te7813
	 OwQr6mEreRP2Q==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c764f2c223so2306692fac.0;
        Wed, 09 Apr 2025 08:43:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyPA/jmyvXL7XRrAOXNVN2OPFEu8LHkZG8dZkFIfJjvbPveSfme0MlHJlthhCG4zvcByqJyCKxXxrb@vger.kernel.org, AJvYcCX5FtqQAKLHoq/5wbsp64rBfeYEVM992tsZmS+8q9H3i+fVjvz992VqNH7jViQBUl03NtHoc1rKdjWU+jmF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5O3x+jtg4G/NTVgWx7NYZAzo2bDmB4svuTn0ZXmvyuuCk9CgR
	BTpBns3g3Y3ZPx9SMs79g+N3obC/teirae4Eo34qQ1DA/mPuCp5li86ZYb639lzvf3rLU0DQ7gJ
	2wD+0pp/PE6cdcWbZq2DBPWNv5Y4=
X-Google-Smtp-Source: AGHT+IHPfE7dSRIjUYkW2+C2sa2qSFLVGvgXTJUA6F0Mi8pbopsKWhs/TqIWlOIiHcyTG8p1i7bwABRt1Z+JrILnmHE=
X-Received: by 2002:a05:6870:2dc3:b0:29e:7a13:1341 with SMTP id
 586e51a60fabf-2d0916bbd32mr1573160fac.8.1744213399488; Wed, 09 Apr 2025
 08:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com> <Z_aIUokzC0eD-Uw-@smile.fi.intel.com>
In-Reply-To: <Z_aIUokzC0eD-Uw-@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 17:43:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3e0j=ZGxa3C5pWpL6-fOcFORGZKRG9jhmo4wCZpoD7Q@mail.gmail.com>
X-Gm-Features: ATxdqUHtH2lSvDOr3ZxfU0yUHCQhcz0XkxwEBoMwEN8JjU_WlQo_X1RURciyf_M
Message-ID: <CAJZ5v0j3e0j=ZGxa3C5pWpL6-fOcFORGZKRG9jhmo4wCZpoD7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 09, 2025 at 04:19:03PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 31, 2025 at 6:32=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Add a note to the fwnode.h that the header should not be used
> > > directly in the leaf drivers, they all should use the higher
> > > level APIs and the respective headers.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thank you, but you already commented on this and proposed the better word=
ing
> which is in v2. So, what should I do now?

The tag is for the v2, sorry.  Let me add it there.

