Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3437530092F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbhAVRCp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbhAVRCX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 12:02:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D863C0613D6;
        Fri, 22 Jan 2021 09:01:40 -0800 (PST)
Date:   Fri, 22 Jan 2021 18:01:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611334898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEd+UZxbHmiF2tOBpSyRAlX6c0QcubXcj2vz5mCJSCs=;
        b=Qyn5cXcXO5A+IF/D/KJPan/Tkqm/tyGUfqH6DdrbD5WVAXtfcAcXhzszYdlgEYhcWZyOU0
        an6EwKQ3/aqPGsaeElDs2Q1PxfbqRtf0Pn2IPCiO/sQgJZhMSqJ81u7iOd+qXdI5uPmITn
        nw5ZAH8RPCZV6Kcxc9ESMer4PPIoogpyeaI/RUV3lexFbE8KaOVYMILyrCRQRJYESdNkhK
        2a0Xtuz3cg9tKKaxMlYmh6ixKVj4hyCAxKrlKUpxd1mepdBeY4pXF0/Kcb0LndD8r0Nhwo
        xg8H6digGariQYVI8GMYiWwwv3z4bSMuToDcJiQYOqVmE/tYOW3XDuc9MR2zLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611334898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEd+UZxbHmiF2tOBpSyRAlX6c0QcubXcj2vz5mCJSCs=;
        b=YwIyiiSAqFHOBDhMwgZXNVI+JKhUbvbjqO9nNF4iiGDORemK7dBt7gP3tu2vRT0FBsseRg
        iU6MhUDkbGsxtvCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>
Subject: Re: [PATCH] ACPI: thermal: Do not call acpi_thermal_check() directly
Message-ID: <20210122170138.zflol3gohzgqw5zm@linutronix.de>
References: <3391226.KRKnzuvfpg@kreacher>
 <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-01-22 17:23:36 [+0100], Rafael J. Wysocki wrote:
> 
> Well, it's been over a week since this was posted.

Thank you for this ;)

> Does anyone have any comments?

I looked over it and it makes sense, so
  Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I didn't comment on it since a testing-by would be better ;)

Could you please add a stable tag? I've seen a few "comments" in forums
suggesting what I suggested to Stephen as a work around while I was
searching for his motherboard so they are more people affected by the
shutdown problem.

Sebastian
