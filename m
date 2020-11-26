Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9518E2C572A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgKZOcv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 09:32:51 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:34543 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgKZOcu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 09:32:50 -0500
Received: by mail-oo1-f44.google.com with SMTP id l10so447025ooh.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2020 06:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR5ThbhcBLC1tkGV4Wk8s838PT62ywS8nyviEzlpGgU=;
        b=ZDa1erzKBmO/vUy5pwDPa3dMcArgReCO0YZzQp9PphDUa4W6juR+FDfkJCLuq2aPvD
         hdiyi7h5II2rp5rKR/C0hiqn8nDFuuELc18QNOtQ9AHMghJzgVyknMUqJm1sNYP30Kyz
         YMkxEaK+/Wxga+RyLXXOx4l6xkB9CugDFBpOb9CtbJoIRLN7LL46PtypHo3jfsQERdQN
         ZkTfBqfceU/wIoHOqaMPOTKgwmMPxv0GgmcR8w3ZDONrIU6M586oQH1H4xIxSQnKCH0L
         kgNixktbxBko8U3MT5UJGcs04Fy8ak273xF0vAXZmTVyfD7Kkpnzgp6xpUvQYH1bUwtg
         9syw==
X-Gm-Message-State: AOAM533N5ncklU1V+LWBNVUQDqYrk86ZdkP1HrHCVt9B1jT8kUYLPFLE
        e2dVI20KLdgoB2QxsdKz3p1RjDsOhF/ob/TK+CY=
X-Google-Smtp-Source: ABdhPJy3xt6ZMrZuC0PSVoESf8y5Mal1Eg+F1sAIZlTrMx/svAaMGjLDkipH1rxhXIE9z397hgMO6xelNOH1Cq4LoiY=
X-Received: by 2002:a4a:abc9:: with SMTP id o9mr2233833oon.1.1606401170217;
 Thu, 26 Nov 2020 06:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20201125195906.GA3809000@localhost.localdomain>
In-Reply-To: <20201125195906.GA3809000@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 15:32:37 +0100
Message-ID: <CAJZ5v0iUg2DD+o3AVfLqxAqX4vAnTC1o1kK=-nTcnkk2c36DPA@mail.gmail.com>
Subject: Re: evaluation order bug in acpi_pic_sci_set_trigger() ?
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 8:59 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> acpi_pic_sci_set_trigger() contains the following code:
>
>         /* Real old ELCR mask */
>         old = inb(0x4d0) | (inb(0x4d1) << 8);
>
> Operand evalution order is not guaranteed for binary or.
> I wonder if this is a bug?

Does the ordering matter in practice?
