Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A53616CC
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 02:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhDPAaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhDPAaY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 20:30:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343EC061760
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 17:30:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j12so5165147edy.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=Wj71gi/NPwcdU7VxwkIuTewf0E3DQtS1gGmF0wjZmgow4McMk8Sd87vKneMXrfWMyR
         6FqaKhlj+5LI5cqkUVAuPOJB9Gyv6nKbx7DZ4FlopTXBwNagwohiv0dZVTND9D8939D+
         s1Lza341vtLWJjpfQbkHfTMixPdYEYX/bvH9toXgXFjjGjoPSEk5AOoKZmQuzincMWRQ
         Zpzcx7sJ4/QeaSFKQNO5EC9DTkgaDSKaacoqNIm1GxGUmvrORBvdQAFjyT+5t60pnX4d
         jRGDej43vWjtYgu9TUXeNKG0pCQwNRBW9FErouAkzkJYeGMlIWQFy8vF1d7Ng5HnddvH
         r8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=MVWTwfA15+zV0Y+2w6ja7e7cH2h5k6XwuH2cdrDl1m33hTrlmJp7QIKWLeMxspAjfe
         Et0YbC+cm8u3R01CniyxvD8T6GFr4QhVMV6QkjfgOfyEoQS1Wf9HUB/HUkcnnnzGSuP6
         +eGhLkG11dtIzBpx79Cn1hOPKH0bTMuPeVLVP5QP3+wnpb1jusRw9dO++ZMQsMfDwqjL
         hjp4EzbWxx1Ak1nRqX0Ecro3Nrh87k+66O4fHsbjpihLqGAgTYKnsTwVXQKSvI5FRhqt
         Uzoc3OVEUD9BiDP0r8EqrVH9AXcDRGzP3lxrclJ8nvwEpsbIFJH2whIkSE0AqvAoVz5L
         aEyQ==
X-Gm-Message-State: AOAM531jqqj8wF5Tz61/9DCiSaXEXyRSXqCYt8/hsTK5H9hlm3PFsSse
        yLsxW9wcsyFQvGLIu3ctSB0gVU1rdunrg6lB3S3wVQ==
X-Google-Smtp-Source: ABdhPJwfb1ArxTcMuMtNmI6uf8uaS73DakGrcDRHPZUbCZBSneAIoOerIU60FngYTqOxTa3cHKfYbAFu9su7XL0GlgQ=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr7428632edc.210.1618532998871;
 Thu, 15 Apr 2021 17:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210415232610.603273-1-ben.widawsky@intel.com> <20210415232610.603273-3-ben.widawsky@intel.com>
In-Reply-To: <20210415232610.603273-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 17:29:47 -0700
Message-ID: <CAPcyv4h6BeEhn0W4tkUqjj+2-XLMkEWab2SHq5mJNa0x4MRDkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 15, 2021 at 4:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
> 8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
> spec, they are allowed and not "unknown". Call this detail out in the
> logs to let users easily distinguish the difference.
>
> Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")

Would need the abbrev length fixup if this was a fix, but I don't
think I can justify this to Linus as a fix v5.12. It's new development
for the next merge window.

Same comment for patch2.
