Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8B126356
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLSNVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 08:21:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbfLSNVL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Dec 2019 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576761670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=M8ZLEXNh6zU+k+ikTgrVxJSdXd42PZcPDOw0npbcP9BJnn51YSeUxHqNQA3zQ5H+x29gPg
        T4qewjDA/Cs0YZZMSyqO57JJ9yC6hrMM3XPCA4QtRlRxiWJzf0hauTiaXGuN45D10SsN3z
        J14a/gQ94XA56ua32+OAWuWQyWqAV78=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-EU9RmuCOOWqK_zDcXHzqeQ-1; Thu, 19 Dec 2019 08:21:08 -0500
X-MC-Unique: EU9RmuCOOWqK_zDcXHzqeQ-1
Received: by mail-wr1-f71.google.com with SMTP id u12so2353301wrt.15
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2019 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=U/K4ugyxyP3Vfh9wg+Bb/EapuVdyId0MyWQwyHP5Wr+1LTd2VI6YM9Lb+wsGr0cQZ7
         yH4uOIDdQpfwzL3AMoVNc9RoNMzvMkwFZ1Xz+fqsb+AYBgiGoeEe/PmShHt3vNckyCIM
         lNkTg2dGSbcJ/szI8B0hb0tXuk7iX865UnG2NIQmh56l/7chTYG4BAQXqOFY/KrCqVQs
         tDF3sbHakXDKICo9i0dqZO+eZHz3m+nvP11lnE95egT8SqaS3IRgVG1d9W5CcaHuZaae
         l4UN3CIejex2yxTC3x2ifXUv2CTsDkMEpkwcD82Bj792dE2gAFaO1L9dqSI85ybO30eM
         I5xQ==
X-Gm-Message-State: APjAAAUbVfTbgKwE1ImnQGQgycM8zfPjNAZPSxFCtg4wx6+O6bERQxT7
        evWlxoG8G2pnmBA1Ion6VgX3oJ+EkbtLAgEj97woNNpl8SUS1FgsShFpfkPHMLG2UtHXxE8Kdgj
        3kk3X+JrRCqur8pkEKT0dAw==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922295wrv.269.1576761667271;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYsmkicq1CgpePFwwJNc2lMQupRm5P+aon/r1P4LvdWHpza4ghagzA9OygT/h18nUeOHn+jg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922266wrv.269.1576761667016;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id 188sm6488919wmd.1.2019.12.19.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 05:21:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20191219132103.GD13724@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019

Argh! s/2019/2020/g of course. :-/

