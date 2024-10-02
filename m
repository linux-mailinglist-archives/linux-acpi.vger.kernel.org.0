Return-Path: <linux-acpi+bounces-8527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10B98D2A8
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0928496C
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF231194AD1;
	Wed,  2 Oct 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmNIGeaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341218D65A;
	Wed,  2 Oct 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870451; cv=none; b=fEGYtOhQ9/ZxbXDtUXyQ+NyZBV4O6T58JDok4ohWbJtHjhD8Hhg14GO1p2de0lIGBud5QkHL6ksQMmvzLXUz06SUBLcelF+pTzPoBOG6v7biHN1t5UFmJqC/9OMGqi1taFKmabpEkpLfmZ7h+M1550p39ZpFUtyjLkKV0cJ4kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870451; c=relaxed/simple;
	bh=YsTB5TK8M68Gw9MSGX27NlhMbpOE2i3AlirRP7ds5ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9lKRYJpLtNdV3M4Pz+mt8UNNfDPLuNMXaAmyfdPS1dC83+kigs3xWTONY8kxnAfK+BtilXH69ciJUcErBHXuOHJCe6IHolw4A35WJeU3omN2LqwjEtzV7L6uv3V2UYoZgfsb0rVHOExSMKNjjkUgdTbGICIu9ViB4pO2OeYrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmNIGeaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12499C4CECD;
	Wed,  2 Oct 2024 12:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727870451;
	bh=YsTB5TK8M68Gw9MSGX27NlhMbpOE2i3AlirRP7ds5ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YmNIGeaDjmT878Q1nsighoNGmb+oz/Wdk5jYrVtKkcJSRa4TXRIaMh4PwgD5Ha3X0
	 0ytng8ZMJPQUx+43UG9Z7RUtFK2h/pDg/JjtW7m8aFBW0v22eOOa4ZAn8oqw6+K6wh
	 CDysRBZ1oWNTBtlpbqjAL/cTbs3ivBkmtNVgxVD39NUk0fsnUY3giS5rmgLbyl1MpX
	 Rfp33GOiZIu5uIHHj8neBmx2BWOclgwc/5D7FzYTH4AqkW7M8fJFaf2ZIJ+U3KmI+v
	 qiEBF3HO+z8pDcLi4V5eWKpE8TSXf3hEuKY+gQp0xEp+H9NY8mz6TFWhfU+YYxk/im
	 Nfs5FE0bi3icQ==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e137183587so2529348a91.3;
        Wed, 02 Oct 2024 05:00:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuinrTjV/ze2uEX4kwvEXXg8SxVH0W/5VObFBCFC9/aRr0DWpLm9PbBoNXL6u+1YhhehhW/JfxHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJazFa3w+eYFweZXSfHKqozScGY0cU7AVo/uBBJ6GDSgTlC+t
	tk5m2GU4qdA4W9nHOJ1stGEJmjQlh87mD03EksbUV3rqJWcCfuUoK/aob9YKiDecftcmD4iEjMf
	kFA9BiDPS1vT8OmjqC8aeEy3nNS0=
X-Google-Smtp-Source: AGHT+IF9AdfL9AiVrvU/jnF0/V2Vadvf9H1lGZLc5Tjseo2j3fW+PAuVogLMV64dlQeiM2IJ/WOfP4tG3FAw8eYMO0M=
X-Received: by 2002:a17:90a:ba95:b0:2e0:b755:c461 with SMTP id
 98e67ed59e1d1-2e18454ca88mr3379854a91.6.1727870450685; Wed, 02 Oct 2024
 05:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6274fdb7-ba80-4c34-94c8-04b7ff29a8c9@gmx.de>
In-Reply-To: <6274fdb7-ba80-4c34-94c8-04b7ff29a8c9@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:00:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwUrnooYRTvpRogDjmn=tsEsR=uSPHkDAOtoDNT+poBg@mail.gmail.com>
Message-ID: <CAJZ5v0hwUrnooYRTvpRogDjmn=tsEsR=uSPHkDAOtoDNT+poBg@mail.gmail.com>
Subject: Re: s2idle issue on Dell G51 5155
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Mario and linux-pm

On Wed, Oct 2, 2024 at 10:08=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Hello,
>
> it seems a user has problems suspending its Dell G51 5155 using s2idle, s=
ee
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218337 for details.
>
> Does anyone have an idea on how to debug this?
>
> Thanks,
> Armin Wolf
>
>

