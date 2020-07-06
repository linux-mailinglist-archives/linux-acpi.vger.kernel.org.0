Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22932162A7
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 01:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGFX5f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 19:57:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgGFX5e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 19:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594079853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=LvDFxApzmWvOyKgwYQIy2znvnixcw2o1OiwUDvNdElewoPbTSHwygw+VBJoIMnZ/sFFwjY
        sFnGa7uITwFjgNUCS29ENT7GCxAOGymGpX3fFBEnr5zRlq3RN+rxwMgdhMGlZXL8l2+2xF
        6ZqRg6/2xK+0g+NpJ3u3bgYBWtxodK4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ybEuIc_FNNe00iPwPIjeuQ-1; Mon, 06 Jul 2020 19:57:31 -0400
X-MC-Unique: ybEuIc_FNNe00iPwPIjeuQ-1
Received: by mail-qv1-f71.google.com with SMTP id m8so8391268qvv.10
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=GVbgZhAcuQnmqLQVTdKMJYAES7VFLUDnEhJHPuEcXOpm+pVTf954KeMNPzLMBDrd75
         psHH4Pjxjlhw1P4rPXhwykxI9GoQsC5TEX5TG/olGjEB3KEfOjWzJfBxa5PXbZdQLb/O
         2+NF34gtC5dMeSYZqgL9PBRs65lJrtJabkby6U01I12PiPs35rFgpT/YZgXgflZyZesw
         ohF4CdoAEjow2qc+3YYNVeEK546v7plYbCZ0o4ln6otiu8p6OXGOfitbbDqsePCLvjDg
         LYjeo6N9ENpzgltPHmObw/pZ9L6F8xxvjl2xV9BqmU2K4W1/n/n4PM9s5q1sUv+Ky8kY
         8qZw==
X-Gm-Message-State: AOAM532lnx83d6S9anKIl0lxHAoPdEAhvgjN66xXPdYn2hJd9PhzpRIc
        oulJ0zzNQVLYDTrdeWTY7HGBR5HZkSQFBXU9t15HCbx8kcaMe59oq/A+sDo0LZeGiYEmhDMRfdw
        SvXIb0vz+GmNPMVF6SOc1tg==
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623333qke.197.1594079851023;
        Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr5SZNidI4OJoMWzUXi9Xjl/T41/3YcOx+9xtlh2k1eoNc3KkVBOU6fOs9TEw6tHZ9F9ixxA==
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623312qke.197.1594079850724;
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g41sm25799385qtb.37.2020.07.06.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com> <20200706230914.GC20770@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706230914.GC20770@linux.intel.com>
Date:   Mon, 06 Jul 2020 16:57:28 -0700
Message-ID: <87mu4cjixj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Jarkko Sakkinen @ 2020-07-06 16:09 MST:

> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> 
>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>> to get the event log from ACPI. If one is found, use it to get the
>> start and length of the log area. This allows non-UEFI systems, such
>> as SeaBIOS, to pass an event log when using a TPM2.
>> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> way to test this?
>
> I'm anyway more worried about breaking existing TPM 1.2 functionality
> and that requires only QEMU without extras.
>
> /Jarkko

The 1.2 bits should be functionally the same as before, right?

