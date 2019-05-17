Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83667218A2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2019 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfEQMxX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 May 2019 08:53:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33743 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbfEQMxS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 May 2019 08:53:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so9258490wme.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 May 2019 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcYe+aG05w2UO1ZXKc7jrJL+Ovz86Hm2R29bKoYuqSk=;
        b=o24Vx40r+dKZcFIqpNQC93wdp7fHrBOY+cG/XleUnl2Uz31hgMfeQW7jfCpsZCFA4T
         FFGR+rZ1h2XW2X7zFJKPIcruFTzXiZc4LLs/WGSldMnMvVD5VCdQIUfJ3jtjJeQAXnR2
         iIzgPbEnoDKSmbBZp2LKN7v4mPPTbHGDHQOizZXcCsXg9A7xM9JRjYQeLXwkjqS8TM7n
         pAztn4MU5v3dIjH+aplCyd/GvqgNLfHn5X67NLc+51WtfGKUj1cmRL2C2ymOqsTahxB/
         pnwMKY4/z9nzINRxdOKmTFVd9YMEsFpIBP1vkqkVio1Xg7LP01D3R5EHi++AT/qa0Mfz
         cCpw==
X-Gm-Message-State: APjAAAUSAaVnNEfngE6mcT15Suf8fg4gjqnALiTUUfJGl8VyWxR4nSPX
        BEwBVQlTBcTZPRxisspyW8CNCw==
X-Google-Smtp-Source: APXvYqzvQo4PLIOLgEYS45mThRlVYeoSKfB0i310BFOLRFwKSRuu+NOfl46fdrqxPtJzbnmADzwaFw==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr2040524wmc.94.1558097596479;
        Fri, 17 May 2019 05:53:16 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id q3sm6514366wrr.16.2019.05.17.05.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 05:53:15 -0700 (PDT)
Date:   Fri, 17 May 2019 14:53:13 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel III edition (OSPM-summit 2019)
Message-ID: <20190517125313.GJ14991@localhost.localdomain>
References: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114161910.GB5581@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 14/01/19 17:19, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
> May 20-22, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---
> 
> .:: FOCUS
> 
> The III edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 20-22, 2019.

Next week!

FYI, final schedule is online (Italy (GMT+2)):

http://retis.sssup.it/ospm-summit/program.html

Live streaming events have been created and are accessible both from the
summit schedule ("live streaming" links) and at:

https://bit.ly/2Vz3yKg

Best,

- Juri
