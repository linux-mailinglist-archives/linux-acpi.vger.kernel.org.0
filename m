Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756E84AA02B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Feb 2022 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiBDTeb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Feb 2022 14:34:31 -0500
Received: from box.aukejan.com ([173.82.79.94]:45927 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233941AbiBDTea (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Feb 2022 14:34:30 -0500
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id B298760BE5;
        Fri,  4 Feb 2022 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1644003270;
        bh=KhO5PTwZMUYwQ8TnwI1v8z55ALBe1xXkRNb0LUaHgoA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DBxciDNqITEAHC6mz8glV++7K3yd4Gal/eerOgVv80heoetExT/dy/MdgTn+SuX2m
         Tg4abYv72OJULIu7RgOcC+atKV3K051CXsGAzw5fkjeS1vDSBKst1i8lOBlQ2qz79b
         TMV4oxuy+3717qhfzFyDt6kU8xlxxPseNaNNy/iEN7jpGvfomXddOHnYAFX2yjeg8M
         LgNW6Ievt6phmRxlR3lqqnFybmvKFcO9AYeNuVdrxYgOm6p24PfC4I/t/Uv8gfIe+7
         dhfpGWw+ac+lYdHBAa+5Rh5gbqISglgMZhxABUR8vwM9ArJDQxFUgD8eIIq7H/FDn7
         g8NrFIuliGaZw==
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
 <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
 <a20337bb-9e83-e387-7d10-a2843f7286b3@boldcoder.com>
 <CAJZ5v0jNvvjRzXRA36nQve7KSFOqtkfLc-u3V8xNV+V+kzv4gg@mail.gmail.com>
From:   Robert Kiraly <me@boldcoder.com>
Message-ID: <23108e4c-9cec-6349-9e53-22f87e44728a@boldcoder.com>
Date:   Fri, 4 Feb 2022 11:34:32 -0800
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jNvvjRzXRA36nQve7KSFOqtkfLc-u3V8xNV+V+kzv4gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02/04/2022 10:45AM, Rafael J. Wysocki wrote:
 >
 > I've queued up this change for 5.18, but I needed to rebase the patch
 > and I changed its subject and changelog.
 >
 > Thanks!

Thank you for your time and patience in discussion of issues.
