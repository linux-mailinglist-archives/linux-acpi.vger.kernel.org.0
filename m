Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83A3F166B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhHSJlJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 05:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhHSJlI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Aug 2021 05:41:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43530610CF;
        Thu, 19 Aug 2021 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629366032;
        bh=pn1+aJZ5D4PQ4DCq3A4hEX/ROi2pp61SP2+ot9uVk9I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bMjEq5IUZHMH6ruUqnDXbDJqEhYyuBSDbhX2BSsKgRQTiJQo+Dj5cLsYh/WtWKW6j
         rKOwo5kNVEk+tLfRH1yP7UgHWYda3hnveYWWlNidA8jDslNpFBtzq2RXU6Gm6AnPUk
         qvkcvNyDZ7MDkeHvMvLczO5nGEDe4U0HRBx4frLO/MG1aAzJWREpIyzLVS/zjua++x
         +FJqp5aoC6vuGu9amQ3kK7NtCgH4qHGsY14KLDHlEwaXRvda6y7/Qv+QjYV7Fx/Sgi
         N7EyFj/dultpxKCgzjXLT0stx8n4G9NPvc4j/uDhdT45MzgEweTE7AIgRSXmC2gTV7
         bH6e2q+TU7G9Q==
Date:   Thu, 19 Aug 2021 11:40:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rolf Eike Beer <eb@emlix.com>
cc:     linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH][RESEND] tools/thermal/tmon: simplify Makefile and fix
 cross build
In-Reply-To: <2149399.oOxd0sxVbX@devpool47>
Message-ID: <nycvar.YFH.7.76.2108191140000.8253@cbobk.fhfr.pm>
References: <2149399.oOxd0sxVbX@devpool47>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 30 Jul 2021, Rolf Eike Beer wrote:

> Hi,
> 
> cross-building tmon can fail because it uses the non-prefixed, i.e. host, pkg-
> config.
> 
> If you prefer a merge the code is also available at:
> 
>    https://github.com/emlix/linux thermal-makefile
> 
> Would be nice if someone could finally pick this up, it's almost 3 years now…
> 
> If someone knows anyone who better fits into these reviews please add CC's, 
> sadly tools/thermal/ is not covered in MAINTAINERS.

That would be Daniel Lezcano. CCing.

-- 
Jiri Kosina
SUSE Labs

