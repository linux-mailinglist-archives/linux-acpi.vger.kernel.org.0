Return-Path: <linux-acpi+bounces-49-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6A7AA615
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 08101281419
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C19387
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 00:31:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7F18D
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 00:07:22 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A7100
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 17:07:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso1939795276.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695341239; x=1695946039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCoAFKgoNTRb7SqWTYs4lvzjZ7gnG1PcVrDLMhXRbWQ=;
        b=a/yw0xDwFA2MxAd4gDEBnQ5C3JLsTkfmMBGHMcHNpJt8o4e+6AFeVxJUXZNUHqOT2T
         4Z6W/iojqbivOMX5kuPWsirOkq7qsH0/qFHRq49s96Dfd9UH+vLfxZsJznIiZv5Ffzjx
         aud8JXxJtp0hiyPiSiBIL0G/jAlLVFxDEnjkyBO1alRfhUmnSVhQ/rhUheX2j5LUUglg
         ArPNClMh1EGcmxwHn1BEQ6R/1wQjJlMlCMYg9x0gfWGC6lLUPKWxsFwzIUvI/BPV5wkn
         CmnRwdK6m0SqWWviOCevOTbH22KIHo2UjyF8vnYxjlST5O/4tdhOa48UsV7pPFM//0zq
         migg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695341239; x=1695946039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCoAFKgoNTRb7SqWTYs4lvzjZ7gnG1PcVrDLMhXRbWQ=;
        b=rrXRFSLPK+uzmKYUI52LQMPHmV9ECeddA006e9no8BLSAc2I5ZlKzV4YldZgLWVkZm
         r2S8atGP6npLDQUQ6ohgxgLaCZiq+W0O+R4RZCSgFq2wLcdkz4rU2H1T+CW0qDk+OL1M
         dUFYpnNCgTe7fowJq6kJ1b/QWuYQ64vq4nRQbSrN/e4JozuZpbRfZ6pgQYr7shfeJvk/
         B8zeFvpgiKK1sQB2nlpLMoO61KQ/GlWisaOmRYOHgt8ZUxnM7qU1XDhLEeDIPy6zM1GH
         hF7upvE5iPGi0KZwG7ySP/RaA1bVUmKcDvDx5qM+EanmwMvp/WrjjRAyY7k+pRFOurbb
         u4fA==
X-Gm-Message-State: AOJu0Yy5hiSXppoCoxFjC7+wfF6Gvjahazp/4CDVZXOseWteBbyIIYz9
	p2W1Xjn0Y1fNTdgDWSVScdQP/suSbNqqiUSrutKLpg==
X-Google-Smtp-Source: AGHT+IFs59DEMcpeIrcuBoEwl0eYmI077WfvfD2WVHYXAqMuqJ5cPG0WDWNE3cAxARtTroBcGPxQWy3g6Za+ilJdnps=
X-Received: by 2002:a25:84cc:0:b0:d80:57d0:e56d with SMTP id
 x12-20020a2584cc000000b00d8057d0e56dmr7177817ybm.38.1695341239011; Thu, 21
 Sep 2023 17:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915172818.761-1-shiju.jose@huawei.com> <20230915172818.761-3-shiju.jose@huawei.com>
In-Reply-To: <20230915172818.761-3-shiju.jose@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 21 Sep 2023 17:07:04 -0700
Message-ID: <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
To: shiju.jose@huawei.com, "Luck, Tony" <tony.luck@intel.com>, dave.hansen@linux.intel.com, 
	jon.grimm@amd.com, vilas.sridharan@amd.com, 
	David Rientjes <rientjes@google.com>
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	naoya.horiguchi@nec.com, james.morse@arm.com, david@redhat.com, 
	jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com, 
	pgonda@google.com, duenwen@google.com, mike.malvestuto@intel.com, 
	gthelen@google.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add sysfs documentation entries for the set of attributes those are
> exposed in /sys/class/scrub/ by the scrub driver. These attributes
> support configuring parameters of a scrub device.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>
> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Docu=
mentation/ABI/testing/sysfs-class-scrub-configure
> new file mode 100644
> index 000000000000..347e2167dc62
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> @@ -0,0 +1,82 @@
> +What:          /sys/class/scrub/
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The scrub/ class subdirectory belongs to the
> +               scrubber subsystem.
> +
> +What:          /sys/class/scrub/scrubX/
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The /sys/class/scrub/scrub{0,1,2,3,...} directories

This API (sysfs interface) is very specific to the ACPI interface
defined for hardware patrol scrubber. I wonder can we have some
interface that is more generic, for a couple of reasons:

1. I am not aware of any chip/platform hardware that implemented the
hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
RAS experts from different hardware vendors think about this. For
example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
any hardware platform (if allowed to disclose) that implemented ACPI
RASF/RAS2? If so, will vendors continue to support the control of
patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
the vendor consider starting some future platform?

If we are unlikely to get the vendor support, creating this ACPI
specific sysfs API (and the driver implementations) in Linux seems to
have limited meaning.

> +               correspond to each scrub device.
> +
> +What:          /sys/class/scrub/scrubX/name
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RO) name of the memory scrub device
> +
> +What:          /sys/class/scrub/scrubX/regionY/

2. I believe the concept of "region" here is probably from
PATROL_SCRUB defined in =E2=80=9CAPCI section 5.2.20.5. Parameter Block". I=
t
is indeed powerful: if a process's physical memory spans over multiple
memory controllers, OS can in theory scrub chunks of the memory
belonging to the process. However, from a previous discussion [1],
"From a h/w perspective it might always be complex". IIUC, the address
translation from physical address to channel address is hard to
achieve, and probably that's one of the tech reasons the patrol scrub
ACPI spec is not in practice implemented?

So my take is, control at the granularity of the memory controller is
probably a nice compromise. Both OS and userspace can get a pretty
decent amount of flexibility, start/stop/adjust speed of the scrubbing
on a memory controller; meanwhile it doesn't impose too much pain to
hardware vendors when they provide these features in hardware. In
terms of how these controls/features will be implemented, I imagine it
could be implemented:
* via hardware registers that directly or indirectly control on memory
controllers
* via ACPI if the situation changes in 10 years (and the RASF/RAS2/PCC
drivers implemented in this patchset can be directly plugged into)
* a kernel-thread that uses cpu read to detect memory errors, if
hardware support is unavailable or not good enough

Given these possible backends of scrubbing, I think a more generic
sysfs API that covers and abstracts these backends will be more
valuable right now. I haven=E2=80=99t thought thoroughly, but how about
defining the top-level interface as something like
=E2=80=9C/sys/devices/system/memory_controller_scrubX/=E2=80=9D, or
=E2=80=9C/sys/class/memory_controllerX/scrub=E2=80=9D?

[1] https://lore.kernel.org/linux-mm/SJ1PR11MB6083BF93E9A88E659CED5EC4FC3F9=
@SJ1PR11MB6083.namprd11.prod.outlook.com/T/#m13516ee35caa05b506080ae805bee1=
4f9f958d43

> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               The /sys/class/scrub/scrubX/region{0,1,2,3,...}
> +               directories correspond to each scrub region under a scrub=
 device.
> +               Scrub region is a physical address range for which scrub =
may be
> +               separately controlled. Regions may overlap in which case =
the
> +               scrubbing rate of the overlapped memory will be at least =
that
> +               expected due to each overlapping region.
> +
> +What:          /sys/class/scrub/scrubX/regionY/addr_base
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The base of the address range of the memory region
> +               to be patrol scrubbed.
> +               On reading, returns the base of the memory region for
> +               the actual address range(The platform calculates
> +               the nearest patrol scrub boundary address from where
> +               it can start scrubbing).
> +
> +What:          /sys/class/scrub/scrubX/regionY/addr_size
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The size of the address range to be patrol scrubbed.
> +               On reading, returns the size of the memory region for
> +               the actual address range.
> +
> +What:          /sys/class/scrub/scrubX/regionY/enable
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (WO) Start/Stop scrubbing the memory region.
> +               1 - enable the memory scrubbing.
> +               0 - disable the memory scrubbing..
> +
> +What:          /sys/class/scrub/scrubX/regionY/speed_available
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RO) Supported range for the partol speed(scrub rate)
> +               by the scrubber for a memory region.
> +               The unit of the scrub rate vary depends on the scrubber.
> +
> +What:          /sys/class/scrub/scrubX/regionY/speed
> +Date:          September 2023
> +KernelVersion: 6.7
> +Contact:       linux-kernel@vger.kernel.org
> +Description:
> +               (RW) The partol speed(scrub rate) on the memory region sp=
ecified and
> +               it must be with in the supported range by the scrubber.
> +               The unit of the scrub rate vary depends on the scrubber.
> --
> 2.34.1
>
>

