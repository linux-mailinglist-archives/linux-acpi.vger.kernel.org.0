Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1E150266
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2020 09:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBCISH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Feb 2020 03:18:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53136 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbgBCISH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Feb 2020 03:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580717885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=Fza/D2YAtP+yh4T8xquu9UMFcsBn7oeHirAg6/CNH2zBpfJKO7zwGtpCIouq7xr51Y4SRB
        JoNfwVBoQR5e+V2MKvWwVP/by9+mN44vb6J9UYp2eFPtSVqzq0crZlG7ZG/x01qvWSWOQ+
        JIFsFjL769hq1iQkItoUr6SGBpnEFFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-9a51MEaPMj-pkoUtO44jnA-1; Mon, 03 Feb 2020 03:18:04 -0500
X-MC-Unique: 9a51MEaPMj-pkoUtO44jnA-1
Received: by mail-wm1-f70.google.com with SMTP id y24so3700721wmj.8
        for <linux-acpi@vger.kernel.org>; Mon, 03 Feb 2020 00:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=t29Zao877dpsrLCus4n6kpUUePk1JWy2vi+UAXK+s1AP5fx962RIEY46KKmou5Kfbw
         c4+HOC09ej3ZsawdrL1KvbuXWW0LrMKBmrMRqj3PXg8vf5MaUWIp3w8CJazykCE7qUdO
         r+7YYqq3J4Teulnp7UVCkB9QA1wTISSbHG+qjIgNLcxYIfFgGHpXP5zeSKeSR6PCvAgn
         wQZ9kpiqWka6lxoMPYXq/otlcF79LimM2dlDSHi3vTaY1CEb/mLOlv48XRgZ0Ws2UaOh
         /BVQmqWigL+FIzW6D15PfS6ixYo0FBxREDcF7rDfDP6WY3+eS6ueY6q02vOFI6pPaCJ9
         Mqmg==
X-Gm-Message-State: APjAAAUrQcpaYjfiaTJezacvmilLuGpJSsfLl+RMBr07P/DgETemXz3O
        cdLIh/Cz+h3eXzerQC4cSdchLuL3eHUxYXC0mFb5PQpPgxHuQK8UbQowckzGT4Az9DQgqB3hcev
        2hIm3ShWBD1sOUOrEpT+vdA==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034925wro.359.1580717881768;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9FVGQu5t2tcyaJhvPoLSS22q7NWyktDP3a+A/plvQOaRTXOMjAlgdnv0obzO54kAOXWlZ3A==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034870wro.359.1580717881333;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.2.83])
        by smtp.gmail.com with ESMTPSA id r3sm24850786wrn.34.2020.02.03.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:18:00 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:17:58 +0100
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
Message-ID: <20200203081758.GI8582@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2020
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---

[...]

> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/1pPU2ybHHoQjqicYLTaNanPz9H5fv6mQTtrzOqwP9uHs/edit?usp=sharing
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> - 30min or 50min slot
> 
> Deadline for submitting topics/presentations is 10th of February 2020.
> Notifications for accepted topics/presentations will be sent out on 24th
> of February 2020.

A quick one to remind that deadline for submitting topics is
approaching.  Please take time to think about what you'd like to discuss
at the summit and to add the topic to the list.

Best,

Juri

