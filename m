Return-Path: <linux-acpi+bounces-12919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D98A82B1E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76291443DC1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B526A1D7;
	Wed,  9 Apr 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWD7/PKN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47126A1C1;
	Wed,  9 Apr 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213495; cv=none; b=bBfKCNgeKVff0aZ1HRdRQO8Mr14A6A/HMM6F3GZM2MGRY00hx6Sp37cRZl/z1qiAhyHwvBSThYglx88gnVuiMTg5BCeh2bZwkZsnnqp7ThcudEQz+aXriNZbYwCi/LSAP6/FykRUD/XIw4arZ/AluN9rY2DHRduSSvOp3pyIR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213495; c=relaxed/simple;
	bh=IFBHzf7X2DdkbSLv2WIeiRhoDiJ81390q/tsq+B62WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYGg8NSBkXIAEC/qaWVSYrk+AQKkiWZ09kLmKzWY/cfeeHolAZGqSu6bBYh4PQs8mobK6o8BmETuCYEWN83fRnOjcEENFTeozCWi88vYVf/iOipr6ycGOZJ06Dj3j52ok8uDDozhFJ3UdXM7KUeNedd3pB/DSc3qFTnbPWtto4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWD7/PKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF8FC4CEEC;
	Wed,  9 Apr 2025 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213494;
	bh=IFBHzf7X2DdkbSLv2WIeiRhoDiJ81390q/tsq+B62WI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EWD7/PKN3N3bVsgwAkJsNEXZPIQXz4QJoGcdj/3/k+SPKWr0w8jafPCxWIYUe7Zxe
	 ehdxzWuKnyGDelVwE24DMb+0lfQh84kTFL/Gd0y73UQ26x+L9rmHlCWbhHD3kxWFvc
	 5dQnDinDPu1f1IqjqkPjxxqdQ8Im4SxcTkxa8EqjcMo3lPtWXsyxwiAAGa3GWtghcu
	 p6B5HpKFqjyb3OHkW0QA4qpx0N/RENjdBRtzciE8oyNCitdhKchBeITiZgTwoKofx6
	 TfWfYFAIpeK4KJ7/ISYxx0NZAveZNoWwi3e01yuhzqD39u6Is5EqGoV8WBDwXBy8kg
	 YZxJ5Ld/lPuYA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c7b2c14455so4541963fac.2;
        Wed, 09 Apr 2025 08:44:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkrK7bQGpawMhdwdq2Iq8nsQH3EQoFZ4AXU9b+A6neUKeT6EzviqkQU+M/GM/HPVBqYNfqzilsXtsh@vger.kernel.org, AJvYcCXfnNJcFiSdYWzTfnxdnq/OZgA7b0H9rBYIxCJZlqKz+E4Zojp4jGFSzi/dFHiHhYiLmxl+QcUHTg6cY5mQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNnplYlyfjz9hkC+9eb8NmVrUeOJcuvrxWG0ScaPU7rdZSKfN
	WA8N/LpHgEzR0sOyqrMqMuA/b/17NAE/0xlMDCQvVgnEqLzfe4h700XIDtDdc+DWvXkpfQCJUti
	X473fnBG6LPNuj9hcmovmE8FFMZc=
X-Google-Smtp-Source: AGHT+IHeY4QbW6Vef/T4q2UgWs+91FTKuXMqxg1RF2t+qwlVb1iPdLaAPa1Lb2tC5UiC8HD3Mo5/p/t5c8D+pWg/5No=
X-Received: by 2002:a05:6871:7892:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2d09170bec3mr1640687fac.8.1744213494006; Wed, 09 Apr 2025
 08:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ib46bqNkJ9em9GKbUhJpCOjDqgLOyDQmqO1n8LMWJpyQ@mail.gmail.com>
 <Z_aIUokzC0eD-Uw-@smile.fi.intel.com> <CAJZ5v0j3e0j=ZGxa3C5pWpL6-fOcFORGZKRG9jhmo4wCZpoD7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3e0j=ZGxa3C5pWpL6-fOcFORGZKRG9jhmo4wCZpoD7Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 17:44:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iySftJyRTQfnVsuA4GUFxj06nn=rSoTtOUCH6+E2AG6A@mail.gmail.com>
X-Gm-Features: ATxdqUHQySqoM9M3SYf_Ae1-h78hYqydjsF3lQsAANuHpuAZQ5u7lOsnNO_aT3A
Message-ID: <CAJZ5v0iySftJyRTQfnVsuA4GUFxj06nn=rSoTtOUCH6+E2AG6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Apr 9, 2025 at 4:46=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Apr 09, 2025 at 04:19:03PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Mar 31, 2025 at 6:32=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Add a note to the fwnode.h that the header should not be used
> > > > directly in the leaf drivers, they all should use the higher
> > > > level APIs and the respective headers.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Thank you, but you already commented on this and proposed the better wo=
rding
> > which is in v2. So, what should I do now?
>
> The tag is for the v2, sorry.  Let me add it there.

For the v3 rather, but never mind.  Already sent.

