Return-Path: <linux-acpi+bounces-1593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C217F031F
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC0A280E8B
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F58200A0
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Nov 2023 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B44B3;
	Sat, 18 Nov 2023 13:21:12 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d31666d89cso482983a34.1;
        Sat, 18 Nov 2023 13:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700342470; x=1700947270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKqw8k7c/IsJcARfGx9PZG9CMp/UpB7QXtxYl44REk=;
        b=pHhX22GFG8f7ze4C0MdFo7dMrGB5O3vrIDL5wTkZL5yptYchnHdwla2lfPHNrA8aWe
         pu8OZyvwyomXcSV1EdOQInb7y38lKjHBrZ0iprTk7FLRXagT0jaJwXCSj3fEEoIu6Naz
         QnbRcUbZ4DdCFDMw/pZXWY7wiSkL51DGc/RycVRVwbtRckeOhWULLTp/Q89BhF7voQYX
         1Jp28l3xrYdNuws8mv7qYtMO+QV/QUTIhb+GpT7OcJTcC0Ay5HQ0Aq+wrBg3OYHNl3cS
         teq0HUh3XGaHPh3m/m7/YlwHynhWSlwsUddP/VuXLkIzp0zGRXBqaPZgac7SxojiVWp9
         akDA==
X-Gm-Message-State: AOJu0Yw/naWIyCIASSQe6i9hyfVIp3UJ54FO9dn6Plxxm/JD/HGlJay4
	5xXVP4oaI9pkWX+3oXkvva8H4pvLZoTZro4iCWBFVH9F
X-Google-Smtp-Source: AGHT+IE0di/aZwgMaV9x+uHQ7iwF2CL7maY4c5RjJqUoMyMv1SdllaP9jua2ufqcWvrmm8f7BEd2wEiCybQa/Mu+8Xc=
X-Received: by 2002:a4a:d44c:0:b0:584:1080:f0a5 with SMTP id
 p12-20020a4ad44c000000b005841080f0a5mr2894870oos.1.1700342469653; Sat, 18 Nov
 2023 13:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-3-sakari.ailus@linux.intel.com> <20231118174903.GF20846@pendragon.ideasonboard.com>
In-Reply-To: <20231118174903.GF20846@pendragon.ideasonboard.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Nov 2023 22:20:46 +0100
Message-ID: <CAJZ5v0jaPT2ZHtUTvqF=j=xwpWreEPGCRLrP8ypYU7qOUeYSWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] pm: runtime: Add pm_runtime_put_mark_busy_autosusp()
 helper
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-media@vger.kernel.org, rafael@kernel.org, jacopo.mondi@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 6:49=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Sakari,
>
> Thank you for the patch.
>
> On Fri, Nov 17, 2023 at 01:14:28PM +0200, Sakari Ailus wrote:
> > Add pm_runtime_put_mark_busy_autosusp() helper function for users that
> > wish to set the last_busy timestamp to current time and put the
> > usage_count of the device and set the autosuspend timer.
> >
> > Essentially calling pm_runtime_suspend_mark_busy_autosusp() equal to
> > calling first pm_runtime_mark_last_busy() and then
> > pm_runtime_put_autosuspend().
>
> The vast majority if the pm_runtime_put_autosuspend() users call
> pm_runtime_mark_last_busy() right before. Let's make the
> pm_runtime_put_autosuspend() function do that by default, and add a
> __pm_runtime_put_autosuspend() (name to be bikshedded) for the minority
> of cases where updating the last busy timestamp isn't desired. We want
> to simplify the API, not make it more complex.

I would also prefer it to be done this way if not too problematic.

